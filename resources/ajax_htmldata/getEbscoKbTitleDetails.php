<?php
$titleId = filter_input(INPUT_GET, 'titleId', FILTER_SANITIZE_STRING);

if(empty($titleId)){
    echo '<p>No title ID provided</p>';
    exit;
}

$ebscoKb = EbscoKbService::getInstance();
$title = $ebscoKb->getTitle($titleId);

?>
<?php include_once __DIR__.'/../css/ebscoKbCss.php'; ?>
<div id="div_ebscoKbTitleDetails" class="ebsco-layout" style="width:745px;">

    <div class="formTitle" style="margin-bottom:5px;position:relative;"><span class="headerText"><?php echo _("EBSCO Kb Title Details");?></span></div>

    <div class="container">
        <div class="row">
            <div class="col-8"><h1 style="line-height: 1em;"><?php echo $title->titleName; ?></h1></div>
            <div class="col-4" style="text-align: right;">KbID: <?php echo $title->titleId; ?></div>
        </div>
        <div class="row" style="margin-top: 1em;">
            <div class="col-12">
                <p style="font-size: 1rem;"><?php echo $title->description; ?></p>
            </div>
        </div>
        <div class="row" style="margin-top: 1em;">
            <div class="col-12">
                <h2>Title details</h2>
                <div class="row">
                    <div class="col-6">
                        <dl>
                            <dt><?php echo _("Publication Type"); ?></dt>
                            <dd><?php echo $title->pubType; ?></dd>

                            <?php if(!empty($title->edition)): ?>
                                <dt><?php echo _("Edition"); ?></dt>
                                <dd><?php echo $title->edition; ?></dd>
                            <?php endif; ?>

                            <dt><?php echo _("Peer Reviewed"); ?></dt>
                            <dd><?php echo $title->isPeerReviewed; ?></dd>

                            <dt><?php echo _("Publisher"); ?></dt>
                            <dd><?php echo $title->publisherName; ?></dd>
                        </dl>
                    </div>
                    <div class="col-6">
                        <dl>
                            <dt><?php echo _("Subjects"); ?></dt>
                            <dd>
                                <ul>
                                    <?php foreach($title->subjects as $subject): ?>
                                        <li><?php echo $subject; ?></li>
                                    <?php endforeach; ?>
                                </ul>
                            </dd>

                            <dt><?php echo _("ISXNs"); ?></dt>
                            <dd>
                                <ul style="list-style: none; ">
                                    <?php
                                    foreach($title->isxnList as $identifier){
                                        if(in_array($identifier['type'], [0,1])) {
                                            switch($identifier['subtype']){
                                                case 1:
                                                    $subtype = _(' (Print)');
                                                    break;
                                                case 2:
                                                    $subtype = _(' (Electronic)');
                                                    break;
                                                default:
                                                    $subtype = '';
                                            }
                                            echo sprintf('<li>%s%s</li>', $identifier['id'], $subtype);
                                        }
                                    }
                                    ?>
                                </ul>
                            </dd>

                            <?php if(!empty($title->contributorList)): ?>
                                <dt><?php echo _("Contributors"); ?></dt>
                                <dd><?php echo implode(', ', $title->contributorList); ?></dd>
                            <?php endif; ?>
                        </dl>
                    </div>
                </div>
            </div>
            <div class="col-12" style="margin-top: 1em;">
                <h2>Available in the following packages:</h2>
                <div class="row">
                    <div class="col-4">
                        <label for="showAllPackages">
                            <input type="checkbox" id="showAllPackages"> <?php echo _("Show all packages"); ?>
                        </label>
                    </div>
                </div>
                <div class="row">
                    <?php foreach($title->customerResourcesList as $resource): ?>
                    <div class="col-12 packageOption <?php echo $resource->isSelected ? 'selectedPackage' : ''; ?>">
                        <div class="card" style="margin-top: 1em;">
                            <div class="card-header">
                                <div class="row">
                                    <div class="col-8">
                                        <h3 style="padding-left: 5px;">
                                            <?php if($resource->isSelected): ?>
                                                <i class="fa fa-check-square-o fa-lg text-success" title="<?php echo _("Selected in EBSCO Kb"); ?>" style="margin-left: -15px;"></i>
                                            <?php else: ?>
                                                <i class="fa fa-ban fa-lg text-danger" title="<?php echo _("Not selected in EBSCO Kb"); ?>" style="margin-left: -15px;"></i>
                                            <?php endif; ?>
                                            <?php echo $resource->packageName; ?>
                                        </h3>
                                    </div>
                                    <div class="col-4" style="text-align: right">
                                        <button
                                                class="setPackage btn btn-primary"
                                                onclick="tb_remove();"
                                                data-vendor-id="<?php echo $resource->vendorId; ?>"
                                                data-package-id="<?php echo $resource->packageId; ?>"
                                                data-package-name="<?php echo $resource->packageName; ?>">
                                            <?php echo _("View Titles"); ?>
                                        </button>
                                        <a
                                            href="ajax_forms.php?action=getEbscoKbPackageImportForm&height=700&width=730&modal=true&vendorId=<?php echo $resource->vendorId; ?>&packageId=<?php echo $resource->packageId; ?>"
                                            class="thickbox btn btn-primary">
                                            <?php echo _('import package'); ?>
                                        </a>
                                    </div>
                                </div>
                            </div>
                            <div class="card-body">
                                <p><?php echo _("Vendor"); ?>: <?php echo $resource->vendorName; ?></p>
                                <dl>
                                    <dt><?php echo _("Coverage Statement"); ?></dt>
                                    <dd><?php echo $resource->coverageStatement; ?></dd>
                                    <dt><?php echo _("Embargo"); ?></dt>
                                    <dd><?php echo $resource->embargoStatement; ?></dd>
                                    <dt><?php echo _("Resource Url"); ?></dt>
                                    <dd><a href="<?php echo $resource->url; ?>"><?php echo $resource->url; ?></a></dd>
                                </dl>
                            </div>
                        </div>
                    </div>
                    <hr>
                    <?php endforeach; ?>
                </div>
            </div>
        </div>

        <div class="row" style="margin-top: 1em;">
            <div class="col-12">
                <a
                    href="ajax_forms.php?action=getEbscoKbTitleImportForm&height=700&width=730&modal=true&titleId=<?php echo $title->titleId; ?>"
                    class="thickbox btn btn-primary">
                    <?php echo _('import'); ?>
                </a>
                <button onclick="tb_remove();" class="btn btn-primary ml-1"><?php echo _("cancel");?></button>
            </div>
        </div>
    </div>
</div>


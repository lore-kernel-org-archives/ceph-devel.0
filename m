From: Wido den Hollander <wido@widodh.nl>
Subject: phprados, a PHP extension for librados
Date: Wed, 15 Sep 2010 20:51:34 +0200
Message-ID: <1284576694.2315.55.camel@wido-laptop.pcextreme.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-nHu5bU44UVQxbYVB68sB"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:38746 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753043Ab0IOSvh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Sep 2010 14:51:37 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: tim@jurcka.eu


--=-nHu5bU44UVQxbYVB68sB
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi,

The last few weeks me and my colleague Tim Jurcka have been working on a
PHP extension for librados.

Right now we've implemented the most basic functions of librados, which
enables you to use the native librados functions from PHP.

The extension is based on the C++ API from librados.

For now we've skipped the selfmanaged snapshots and the AIO functions.
Selfmanaged snapshots seem to be a bit tricky and AIO is not that easy
in PHP.

The goal of this extension is to be able to use RADOS easily with PHP,
this is possible with the current implementation, but we are working on:

* High Level OO-interface for RADOS
* Stream Wrappers ( echo file_get_contents("rados://pool/obj"); )

These extra features should make usage easier, but like said, the
current low-level functions work fine.

You can:
* Create/Delete pools
* Create/Delete objects
* Read/Write objects
* List objects
* Setting/Getting xattrs
* Create pool snapshots
* Rollback objects

To make reading a object a bit easier, we've added "read_full",
internally this function simply does a "stat" and then reads the full
length of the object.

Same goes for "list_objects", internally this calls "list_objects_open|
more|close" while limiting the result to 1024 objects.

The extension has been tested on 32 and 64-bits with PHP 5.3.2, but it
should be compatible back to PHP 5.2.x

Handling large objects has not been tested fully, but there could be
some limitations inside PHP's engine, so we are not sure how good this
will work.

With standard usage, librados simply reads /etc/ceph/ceph.conf, but you
can pass the standard arguments to the constructor, so you should be
able to use it without a ceph.conf (See the attached examples).

The extension can be fetched from: http://www.widodh.nl/git/phprados.git

When building the extension, you will need librados, libceph, libcrush
and their development headers.

Installing the extension:

$ git clone http://www.widodh.nl/git/phprados.git
$ cd phprados
$ phpize
$ ./configure
$ make && make install

Now modify your php.ini and add: extension=rados.so (Or load the .so
with dl(); )

$ php --re rados

This should give you some information, which tells you the extension is
working.

There is also a "debian" directory, with this you can build a .deb of
the extension. Just run "dpkg-buildpackage" in the source directory,
this will build "php5-rados" for you.

Testing/feedback is needed, we've tried to test the extension as much as
possible, but we're pretty sure there still are some bugs :-)

Attached you will find some examples of using the extension.

Questions or comments? I'll (Wido) be hanging around on the IRC channel
most of the time, or just post them on the mailing list.

Thanks,

Wido den Hollander
Tim Jurcka



--=-nHu5bU44UVQxbYVB68sB
Content-Type: application/x-php; name="create-pool-and-list-objects.php"
Content-Disposition: attachment; filename="create-pool-and-list-objects.php"
Content-Transfer-Encoding: 7bit

<?php

$poolname = "phprados";

$r = new Rados();
$r->initialize();

$r->create_pool($poolname);

$pool = $r->open_pool($poolname);

for($i = 0; $i < 100; $i++) {
    $objname = md5(rand(0,1000));
    $r->create($pool, $objname);
    $r->write_full($pool, $objname, md5(rand(0,100000)));
    echo "Created object ".$objname."\n";
}

/* Native RADOS calls */
$ctx = $r->list_objects_open($pool);
var_dump(($r->list_objects_more($ctx, 1024)));
$r->list_objects_close($ctx);

/* Or the simple (limited to 1024 objects) PHP way */
var_dump($r->list_objects($pool));

$r->close_pool($pool);

?>
--=-nHu5bU44UVQxbYVB68sB
Content-Type: application/x-php; name="list-pools.php"
Content-Disposition: attachment; filename="list-pools.php"
Content-Transfer-Encoding: 7bit

<?php

$r = new Rados();
$r->initialize();

foreach ($r->list_pools() as $pool) {
    echo $pool."\n";
}

?>
--=-nHu5bU44UVQxbYVB68sB
Content-Type: application/x-php; name="rados-options.php"
Content-Disposition: attachment; filename="rados-options.php"
Content-Transfer-Encoding: 7bit

<?php

$options = array(
    'config_file' => '/path/to/ceph.conf', // -c
    'monitor_ip' => '1.2.3.4', // -m
    'cephx_name' => 'admin', // -n
    'cephx_keyfile' => '/path/to/keyfile', // -K
    'cephx_keyring' => '/path/to/keyring.bin', // -k
);

$r = new Rados();
$r->initialize();

var_dump($r->list_pools());

?>
--=-nHu5bU44UVQxbYVB68sB
Content-Type: application/x-php; name="xattrs.php"
Content-Disposition: attachment; filename="xattrs.php"
Content-Transfer-Encoding: 7bit

<?php

$r = new Rados();
$r->initialize();

$pool = $r->open_pool("phprados");

$objname = "testobject";

$r->create($pool, $objname);

$data = file_get_contents("/etc/passwd");
$r->write_full($pool, $objname, $data);

$r->setxattr($pool, $objname, "content_type", "text/plain");
$r->setxattr($pool, $objname, "md5sum", md5($data));

echo "Dumping the \"content_type\" attribute: ".$r->getxattr($pool, $objname, "content_type")."\n";

var_dump($r->getxattrs($pool, $objname));

?>
--=-nHu5bU44UVQxbYVB68sB--


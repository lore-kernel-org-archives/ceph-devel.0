From: Wido den Hollander <wido@widodh.nl>
Subject: phprados update
Date: Fri, 18 Nov 2011 17:44:50 +0100
Message-ID: <4EC68B82.9020106@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:48654 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932183Ab1KRQov (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Nov 2011 11:44:51 -0500
Received: from [IPv6:2a00:f10:113:1:224:1dff:fedd:9061] (unknown [IPv6:2a00:f10:113:1:224:1dff:fedd:9061])
	by smtp01.mail.pcextreme.nl (Postfix) with ESMTPSA id 478B276234
	for <ceph-devel@vger.kernel.org>; Fri, 18 Nov 2011 17:44:49 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

Some time ago the API of librados changed thus breaking phprados. I 
tried implementing the C++ API of librados in PHP but I got pretty stuck 
there with the new IoCTX stuff.

So I went to the C API and started implementing a C-only phprados with 
just using the C functions.

I just finished with implementing most of the librados functionality, 
this includes:

* Connecting
* Creating and removing pools
* Object handling like write and read
* Xattr handling
* Snapshot handling

I stayed away from the rados tmap's, exec and async writes for now, 
since I don't think a lot of PHP users will be using that functionality 
(yet).

My next steps are to hunt down some bugs and start writing a OOP based 
version in PHP, but I'll be using the internal object methods of PHP for 
this while calling the C functions of librados in the background.

This way I can create a RADOS object in PHP which meets the "standard" 
of what PHP users are used to. For example: It is not common in PHP to 
define the number of bytes you want to read when retrieving the value of 
a xattr, PHP should figure that out for you.

Streamwrappers are something I'm also working on, for example:

<?php
mkdir("rados://pool1");
?>

<?php
file_get_contents("rados://pool1/object1");
?>

<?php
file_put_contents("rados://pool1/object1", "some string");
?>

phprados can be found at: http://www.widodh.nl/git/phprados.git

Or you can download it at: 
http://zooi.widodh.nl/ceph/phprados/phprados_latest.tar.gz

I also updated the Wiki: http://ceph.newdream.net/wiki/Phprados

Any comments or suggestions on this?

Wido

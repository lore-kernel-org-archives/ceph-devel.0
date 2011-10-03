From: Wido den Hollander <wido@widodh.nl>
Subject: Issues with implementing the new librados API in the PHP extension
Date: Mon, 03 Oct 2011 11:08:52 -0700
Message-ID: <1317665332.3196.27.camel@wido-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:48841 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932242Ab1JCSI4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Oct 2011 14:08:56 -0400
Received: from [172.28.178.246] (unknown [67.99.198.2])
	by smtp02.mail.pcextreme.nl (Postfix) with ESMTPA id E297C429E3
	for <ceph-devel@vger.kernel.org>; Mon,  3 Oct 2011 20:08:53 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I've talked about this with the Ceph dev's but I'm still struggling to
get this working, so I hope there is somebody here who has a solution.

I'm trying to rewrite phprados so it uses the new C++ API. I'm running
into trouble with ioctx_create, this returns a ioctx object which I have
to handle somehow in the PHP extension.

My code can be found at http://www.widodh.nl/git/phprados.git in the
librados2 branch.

In PHP it looks like:

$r = new Rados();
$r->init();
$r->conf_read_file('/etc/ceph/ceph.conf');
$r->connect();
$io = $r->ioctx_create('data');
$io->create('foo');
$r->shutdown();

With my current code I get a segfault with the following backtrace:

0x00ec1b86 in librados::IoCtx::create (this=0xbfffcb84, oid=...,
exclusive=false) at librados.cc:2765
2765	  return io_ctx_impl->client->create(*io_ctx_impl, obj, exclusive);
(gdb) bt
#0  0x00ec1b86 in librados::IoCtx::create (this=0xbfffcb84, oid=...,
exclusive=false) at librados.cc:2765
#1  0x00e5ba7e in zim_RadosIoCtx_create (ht=1, return_value=0x8901cc0,
return_value_ptr=0x0, this_ptr=0x8901b1c, return_value_used=0)
    at /home/wido/repos/phprados/ioctx.cc:64
#2  0x0836114a in ?? ()
#3  0x08337a2e in execute ()
#4  0x0830d7b6 in zend_execute_scripts ()
#5  0x082b1ec4 in php_execute_script ()
#6  0x083a4deb in ?? ()
#7  0x00646ce7 in __libc_start_main () from /lib/libc.so.6
#8  0x08066ce1 in _start ()

All the magic is done in rados.cc, in PHP_METHOD(Rados, ioctx_create) I
register the returned ioctx object as a internal Zend object which I try
to retrieve in ioctx.cc in PHP_METHOD(RadosIoCtx, create)

I tried Googling around and see how other extension do this (since there
is no documentation about this) and I seem to be in the right direction.

Anyone here has an idea about how to solve this or what is going wrong
here?

Thanks,

Wido


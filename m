From: Simon Tian <aixt2006@gmail.com>
Subject: Re: How to enable the debug symbols
Date: Tue, 17 May 2011 17:59:27 +0800
Message-ID: <BANLkTinngNEXvCTBoMcGpG4boDSFVPy__g@mail.gmail.com>
References: <BANLkTi=aKfr4ZpqsnhCpzREin8c5Y_sbpg@mail.gmail.com>
	<10709e0d5db695dae3ba2d07c2fe73ff.squirrel@pl1.haspere.com>
	<BANLkTikCB1gAL-WPGv1u8AZk_OjD4TLgyA@mail.gmail.com>
	<77a86a15068ca287fcc7343f071f093e@pl1.haspere.com>
	<BANLkTimcMtBi0HpqxsrbJ_oQ-mkNCZctZQ@mail.gmail.com>
	<BANLkTi=Y4E2_6gjo9z0-H104GXspG1Kpng@mail.gmail.com>
	<Pine.LNX.4.64.1105160939350.12367@cobra.newdream.net>
	<BANLkTinC5dbZi9TKRSjSTm5forSXsE-GMw@mail.gmail.com>
	<a0a2c4260f9ec3397d8e2242169c0fdb@pl1.haspere.com>
	<BANLkTikWxG9G5b_dcS08Kbu=rAUA9OR5cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:51394 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754024Ab1EQJ72 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 May 2011 05:59:28 -0400
Received: by wwa36 with SMTP id 36so360826wwa.1
        for <ceph-devel@vger.kernel.org>; Tue, 17 May 2011 02:59:27 -0700 (PDT)
In-Reply-To: <BANLkTikWxG9G5b_dcS08Kbu=rAUA9OR5cw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: YS3fpFE2ykfB@dyweni.com
Cc: Sage Weil <sage@newdream.net>, Gregory Farnum <gregf@hq.newdream.net>, ceph-devel@vger.kernel.org

I find that there are many info bellow in the configure file:
archive_expsym_cmds_CXX='$CC -shared $pic_flag $predep_objects
$libobjs $deplibs $postdep_objects $compiler_flags
${wl}-retain-symbols-file,$export_symbols -o $lib'


Is there some relation between this and "
${wl}-retain-symbols-file,$export_symbols -o $lib' "?

And in the ./libtool, there several line:
# Commands used to build and install a shared archive.
archive_cmds="\$CC -shared -nostdlib \$predep_objects \$libobjs
\$deplibs \$postdep_objects \$compiler_flags \${wl}-soname
\$wl\$soname -o \$lib"
archive_expsym_cmds="\$CC -shared -nostdlib \$predep_objects \$libobjs
\$deplibs \$postdep_objects \$compiler_flags \${wl}-soname
\$wl\$soname \${wl}-retain-symbols-file \$wl\$export_symbols -o \$lib"
postinstall_cmds=""
postuninstall_cmds=""


...........  ...............
...........  ...............


Well, after a try of deleting  "\${wl}-retain-symbols-file
\$wl\$export_symbols" in libtool, then make install,  the stack just
appear!!!!
(gdb) bt
#0  Client::write (this=0x629040, fd=10, buf=0x7fff2134cf10 "",
size=2097152, offset=0) at client/Client.cc:4999
#1  0x00007f739ca0922d in ceph_write (fd=10, buf=0x7fff2134cf10 "",
size=2097152, offset=0) at libceph.cc:322
#2  0x0000000000400fd3 in main (argc=1, argv=0x7fff2154d0d8) at testceph.cc:72


I think there should be a switch option of configure for
"\${wl}-retain-symbols-file \$wl\$export_symbols".
Hope helpful for all the user of ceph.

Thx you all!

Simon







2011/5/17 Simon Tian <aixt2006@gmail.com>:
>> A couple things come to mind:
>> 1. Are you using the same prefix now as you had when
>> /usr/local/lib/libceph.so.1 was built?
>
> I attached the log of make install. There is also -g -ggdb.
>
>> 2. Does the timestamp of the /usr/local/lib/libceph.so.1 change after you
>> ran make install?
>
> Yes, the modify time changed!
>
>> 3. Try deleting /usr/local/lib/libceph.so.1 (or move it to some other
>> folder) and then ./configure, make, make install.
>
> Command "make uninstall" will delete the file, I list this directory
> after this command.
>
>
> Thx!
> Simon
>

From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: unstable branch cosd abort
Date: Mon, 25 Oct 2010 16:12:19 -0600
Message-ID: <1288044739.10847.47.camel@sale659.sandia.gov>
References: <1288037307.10847.20.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1010251353590.24450@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:59373 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751210Ab0JYWWo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Oct 2010 18:22:44 -0400
In-Reply-To: <Pine.LNX.4.64.1010251353590.24450@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Sage,

On Mon, 2010-10-25 at 14:56 -0600, Sage Weil wrote:
> Hi Jim,
> 
> It looks like the xattr on one of the pg directories has corrupt data.
> It could be that the attr is missing, is truncated, or that the xattr
> chunking stuff Yehuda added last has a problem.  (There was also a brief
> period where the xattr size was set differently, which may have caused
> your problem.)  Can you add 'debug filestore = 20' to your conf and start
> up again so we can see which pg it's looking at, and then 'getfattr -d -e
> hex that_file' to dump the xattrs on that file?

Unfortunately, I rebuilt the file system while waiting for
your reply, in hopes of seeing how this might reproduce.

As it turns out, I can't reproduce so far.

If I do see it again, I'll do as you recommend above.

Thanks -- Jim


> 
> Thanks!
> sage
> 
> 
> 
> On Mon, 25 Oct 2010, Jim Schutt wrote:
> 
> > Hi,
> >
> > I caught this abort this morning on the unstable branch
> > while starting up an existing file system:
> >
> > ceph version 0.23~rc (commit:a869b35abdab37bd4505f435bf0f7ab1860b28cc)
> > 2010-10-25 12:04:36.268929 7fc0e718c6f0 -- 0.0.0.0:6830/18794 accepter.bind ms_addr is 0.0.0.0:6830/18794 need_addr=1
> > 2010-10-25 12:04:36.268990 7fc0e718c6f0 -- 0.0.0.0:6831/18794 accepter.bind ms_addr is 0.0.0.0:6831/18794 need_addr=1
> > 2010-10-25 12:04:36.269128 7fc0e718c6f0 -- 0.0.0.0:6830/18794 messenger.start
> > 2010-10-25 12:04:36.269137 7fc0e718c6f0 -- 0.0.0.0:6830/18794 messenger.start daemonizing
> > 2010-10-25 12:04:36.269528 7fc0e718c6f0 -- 0.0.0.0:6830/18794 accepter.start
> > 2010-10-25 12:04:36.269705 7fc0e718c6f0 -- 0.0.0.0:6831/18794 messenger.start
> > 2010-10-25 12:04:36.269716 7fc0e718c6f0 -- 0.0.0.0:6831/18794 accepter.start
> > 2010-10-25 12:04:36.269765 7fc0e718c6f0 osd79 0 mounting /ram/mnt/ceph/disk.15p2 /dev/disk/by-path/fc-1:0:15:00p1
> > 2010-10-25 12:04:36.269981 7fc0e718c6f0 filestore(/ram/mnt/ceph/disk.15p2) mount detected btrfs
> > 2010-10-25 12:04:36.270019 7fc0e718c6f0 filestore(/ram/mnt/ceph/disk.15p2) mount btrfs CLONE_RANGE ioctl is supported
> > 2010-10-25 12:04:36.374833 7fc0e718c6f0 filestore(/ram/mnt/ceph/disk.15p2) mount btrfs SNAP_CREATE is supported
> > 2010-10-25 12:04:36.453138 7fc0e718c6f0 filestore(/ram/mnt/ceph/disk.15p2) mount btrfs SNAP_DESTROY is supported
> > 2010-10-25 12:04:36.453289 7fc0e718c6f0 filestore(/ram/mnt/ceph/disk.15p2) mount found snaps <>
> > 2010-10-25 12:04:36.537859 7fc0e718c6f0 journal read_entry 132460544 : seq 14884 395 bytes
> > 2010-10-25 12:04:36.537927 7fc0e718c6f0 journal read_entry 132468736 : seq 14885 395 bytes
> > 2010-10-25 12:04:36.538522 7fc0e718c6f0 journal read_entry 132476928 : seq 14886 395 bytes
> > 2010-10-25 12:04:36.538539 7fc0e718c6f0 journal read_entry 132485120 : seq 14887 395 bytes
> > 2010-10-25 12:04:36.538565 7fc0e718c6f0 journal read_entry 132493312 : seq 14888 395 bytes
> > 2010-10-25 12:04:36.538576 7fc0e718c6f0 journal read_entry 132501504 : seq 14889 395 bytes
> > 2010-10-25 12:04:36.539457 7fc0e718c6f0 journal read_entry 132509696 : seq 14890 395 bytes
> > 2010-10-25 12:04:36.539499 7fc0e718c6f0 journal read_entry 132517888 : seq 14891 395 bytes
> > 2010-10-25 12:04:36.539513 7fc0e718c6f0 journal read_entry 132526080 : seq 14892 395 bytes
> > 2010-10-25 12:04:36.539581 7fc0e718c6f0 journal read_entry 132534272 : seq 14893 395 bytes
> > 2010-10-25 12:04:36.539594 7fc0e718c6f0 journal read_entry 132542464 : seq 14894 395 bytes
> > 2010-10-25 12:04:36.539604 7fc0e718c6f0 journal read_entry 132550656 : seq 14895 395 bytes
> > 2010-10-25 12:04:36.539633 7fc0e718c6f0 journal read_entry 132558848 : seq 14896 395 bytes
> > 2010-10-25 12:04:36.539644 7fc0e718c6f0 journal read_entry 132567040 : seq 14897 395 bytes
> > 2010-10-25 12:04:36.540814 7fc0e718c6f0 journal read_entry 132575232 : seq 14898 395 bytes
> > 2010-10-25 12:04:36.540832 7fc0e718c6f0 journal read_entry 132583424 : seq 14899 395 bytes
> > 2010-10-25 12:04:36.540843 7fc0e718c6f0 journal read_entry 132591616 : seq 14900 395 bytes
> > 2010-10-25 12:04:36.540853 7fc0e718c6f0 journal read_entry 132599808 : seq 14901 395 bytes
> > 2010-10-25 12:04:36.540863 7fc0e718c6f0 journal read_entry 132608000 : seq 14902 395 bytes
> > 2010-10-25 12:04:36.540873 7fc0e718c6f0 journal read_entry 132616192 : seq 14903 395 bytes
> > 2010-10-25 12:04:36.540884 7fc0e718c6f0 journal read_entry 132624384 : seq 14904 395 bytes
> > 2010-10-25 12:04:36.540894 7fc0e718c6f0 journal read_entry 132632576 : seq 14905 395 bytes
> > 2010-10-25 12:04:36.540905 7fc0e718c6f0 journal read_entry 132640768 : seq 14906 395 bytes
> > 2010-10-25 12:04:36.540915 7fc0e718c6f0 journal read_entry 132648960 : seq 14907 395 bytes
> > 2010-10-25 12:04:36.540925 7fc0e718c6f0 journal read_entry 132657152 : seq 14908 395 bytes
> > 2010-10-25 12:04:36.540936 7fc0e718c6f0 journal read_entry 132665344 : seq 14909 395 bytes
> > 2010-10-25 12:04:36.540946 7fc0e718c6f0 journal read_entry 132673536 : seq 14910 395 bytes
> > 2010-10-25 12:04:36.540957 7fc0e718c6f0 journal read_entry 132681728 : seq 14911 395 bytes
> > 2010-10-25 12:04:36.540967 7fc0e718c6f0 journal read_entry 132689920 : seq 14912 395 bytes
> > 2010-10-25 12:04:36.541000 7fc0e718c6f0 journal read_entry 132698112 : seq 14913 395 bytes
> > 2010-10-25 12:04:36.542636 7fc0e718c6f0 journal read_entry 132706304 : seq 14914 395 bytes
> > 2010-10-25 12:04:36.542650 7fc0e718c6f0 journal read_entry 132714496 : seq 14915 395 bytes
> > 2010-10-25 12:04:36.542665 7fc0e718c6f0 journal read_entry 132722688 : seq 14916 395 bytes
> > 2010-10-25 12:04:36.542675 7fc0e718c6f0 journal read_entry 132730880 : seq 14917 395 bytes
> > 2010-10-25 12:04:36.542685 7fc0e718c6f0 journal read_entry 132739072 : seq 14918 395 bytes
> > 2010-10-25 12:04:36.542695 7fc0e718c6f0 journal read_entry 132747264 : seq 14919 395 bytes
> > 2010-10-25 12:04:36.542705 7fc0e718c6f0 journal read_entry 132755456 : seq 14920 395 bytes
> > 2010-10-25 12:04:36.542716 7fc0e718c6f0 journal read_entry 132763648 : seq 14921 395 bytes
> > 2010-10-25 12:04:36.542726 7fc0e718c6f0 journal read_entry 132771840 : seq 14922 395 bytes
> > 2010-10-25 12:04:36.542736 7fc0e718c6f0 journal read_entry 132780032 : seq 14923 395 bytes
> > 2010-10-25 12:04:36.542746 7fc0e718c6f0 journal read_entry 132788224 : seq 14924 395 bytes
> > 2010-10-25 12:04:36.542756 7fc0e718c6f0 journal read_entry 132796416 : seq 14925 395 bytes
> > 2010-10-25 12:04:36.542766 7fc0e718c6f0 journal read_entry 132804608 : seq 14926 395 bytes
> > 2010-10-25 12:04:36.542776 7fc0e718c6f0 journal read_entry 132812800 : seq 14927 395 bytes
> > 2010-10-25 12:04:36.542786 7fc0e718c6f0 journal read_entry 132820992 : seq 14928 395 bytes
> > 2010-10-25 12:04:36.542796 7fc0e718c6f0 journal read_entry 132829184 : seq 14929 395 bytes
> > 2010-10-25 12:04:36.544485 7fc0e718c6f0 journal read_entry 132837376 : seq 14930 395 bytes
> > 2010-10-25 12:04:36.544497 7fc0e718c6f0 journal read_entry 132845568 : seq 14931 395 bytes
> > 2010-10-25 12:04:36.544507 7fc0e718c6f0 journal read_entry 132853760 : seq 14932 395 bytes
> > 2010-10-25 12:04:36.544517 7fc0e718c6f0 journal read_entry 132861952 : seq 14933 395 bytes
> > 2010-10-25 12:04:36.544528 7fc0e718c6f0 journal read_entry 132870144 : seq 14934 395 bytes
> > 2010-10-25 12:04:36.544538 7fc0e718c6f0 journal read_entry 132878336 : seq 14935 395 bytes
> > 2010-10-25 12:04:36.544548 7fc0e718c6f0 journal read_entry 132886528 : seq 14936 395 bytes
> > 2010-10-25 12:04:36.544558 7fc0e718c6f0 journal read_entry 132894720 : seq 14937 395 bytes
> > 2010-10-25 12:04:36.544568 7fc0e718c6f0 journal read_entry 132902912 : seq 14938 395 bytes
> > 2010-10-25 12:04:36.544578 7fc0e718c6f0 journal read_entry 132911104 : seq 14939 395 bytes
> > 2010-10-25 12:04:36.544588 7fc0e718c6f0 journal read_entry 132919296 : seq 14940 395 bytes
> > 2010-10-25 12:04:36.544598 7fc0e718c6f0 journal read_entry 132927488 : seq 14941 395 bytes
> > 2010-10-25 12:04:36.544608 7fc0e718c6f0 journal read_entry 132935680 : seq 14942 395 bytes
> > 2010-10-25 12:04:36.544618 7fc0e718c6f0 journal read_entry 132943872 : seq 14943 395 bytes
> > 2010-10-25 12:04:36.544628 7fc0e718c6f0 journal read_entry 132952064 : seq 14944 395 bytes
> > 2010-10-25 12:04:36.544638 7fc0e718c6f0 journal read_entry 132960256 : seq 14945 395 bytes
> > 2010-10-25 12:04:36.546407 7fc0e718c6f0 journal read_entry 132968448 : seq 14946 395 bytes
> > 2010-10-25 12:04:36.546430 7fc0e718c6f0 journal read_entry 132976640 : seq 14947 395 bytes
> > 2010-10-25 12:04:36.546442 7fc0e718c6f0 journal read_entry 132984832 : seq 14948 395 bytes
> > 2010-10-25 12:04:36.546452 7fc0e718c6f0 journal read_entry 132993024 : seq 14949 395 bytes
> > 2010-10-25 12:04:36.546463 7fc0e718c6f0 journal read_entry 133001216 : seq 14950 395 bytes
> > 2010-10-25 12:04:36.546473 7fc0e718c6f0 journal read_entry 133009408 : seq 14951 395 bytes
> > 2010-10-25 12:04:36.546483 7fc0e718c6f0 journal read_entry 133017600 : seq 14952 395 bytes
> > 2010-10-25 12:04:36.546493 7fc0e718c6f0 journal read_entry 133025792 : seq 14953 395 bytes
> > 2010-10-25 12:04:36.546503 7fc0e718c6f0 journal read_entry 133033984 : seq 14954 395 bytes
> > 2010-10-25 12:04:36.546514 7fc0e718c6f0 journal read_entry 133042176 : seq 14955 395 bytes
> > 2010-10-25 12:04:36.546524 7fc0e718c6f0 journal read_entry 133050368 : seq 14956 395 bytes
> > 2010-10-25 12:04:36.546534 7fc0e718c6f0 journal read_entry 133058560 : seq 14957 33 bytes
> > 2010-10-25 12:04:36.546558 7fc0e718c6f0 journal read_entry 133066752 : seq 14958 33 bytes
> > 2010-10-25 12:04:36.546569 7fc0e718c6f0 journal read_entry 133074944 : seq 14959 33 bytes
> > 2010-10-25 12:04:36.546580 7fc0e718c6f0 journal read_entry 133083136 : seq 14960 33 bytes
> > 2010-10-25 12:04:36.546590 7fc0e718c6f0 journal read_entry 133091328 : seq 14961 395 bytes
> > 2010-10-25 12:04:36.548527 7fc0e718c6f0 journal read_entry 133099520 : seq 14962 395 bytes
> > 2010-10-25 12:04:36.548543 7fc0e718c6f0 journal read_entry 133107712 : seq 14963 395 bytes
> > 2010-10-25 12:04:36.548554 7fc0e718c6f0 journal read_entry 133115904 : seq 14964 395 bytes
> > 2010-10-25 12:04:36.548564 7fc0e718c6f0 journal read_entry 133124096 : seq 14965 395 bytes
> > 2010-10-25 12:04:36.548574 7fc0e718c6f0 journal read_entry 133132288 : seq 14966 395 bytes
> > 2010-10-25 12:04:36.548584 7fc0e718c6f0 journal read_entry 133140480 : seq 14967 395 bytes
> > 2010-10-25 12:04:36.548594 7fc0e718c6f0 journal read_entry 133148672 : seq 14968 395 bytes
> > 2010-10-25 12:04:36.548604 7fc0e718c6f0 journal read_entry 133156864 : seq 14969 395 bytes
> > 2010-10-25 12:04:36.548614 7fc0e718c6f0 journal read_entry 133165056 : seq 14970 395 bytes
> > 2010-10-25 12:04:36.548624 7fc0e718c6f0 journal read_entry 133173248 : seq 14971 395 bytes
> > 2010-10-25 12:04:36.548634 7fc0e718c6f0 journal read_entry 133181440 : seq 14972 395 bytes
> > 2010-10-25 12:04:36.548644 7fc0e718c6f0 journal read_entry 133189632 : seq 14973 393 bytes
> > 2010-10-25 12:04:36.548654 7fc0e718c6f0 journal read_entry 133197824 : seq 14974 393 bytes
> > 2010-10-25 12:04:36.548664 7fc0e718c6f0 journal read_entry 133206016 : seq 14975 393 bytes
> > 2010-10-25 12:04:36.548674 7fc0e718c6f0 journal read_entry 133214208 : seq 14976 393 bytes
> > 2010-10-25 12:04:36.548684 7fc0e718c6f0 journal read_entry 133222400 : seq 14977 393 bytes
> > 2010-10-25 12:04:36.551609 7fc0e718c6f0 journal read_entry 133230592 : seq 14978 393 bytes
> > 2010-10-25 12:04:36.551626 7fc0e718c6f0 journal read_entry 133238784 : seq 14979 393 bytes
> > 2010-10-25 12:04:36.551637 7fc0e718c6f0 journal read_entry 133246976 : seq 14980 393 bytes
> > 2010-10-25 12:04:36.551648 7fc0e718c6f0 journal read_entry 133255168 : seq 14981 33 bytes
> > 2010-10-25 12:04:36.551658 7fc0e718c6f0 journal read_entry 133263360 : seq 14982 33 bytes
> > 2010-10-25 12:04:36.551668 7fc0e718c6f0 journal read_entry 133271552 : seq 14983 33 bytes
> > 2010-10-25 12:04:36.551678 7fc0e718c6f0 journal read_entry 133279744 : seq 14984 33 bytes
> > 2010-10-25 12:04:36.551688 7fc0e718c6f0 journal read_entry 133287936 : seq 14985 393 bytes
> > 2010-10-25 12:04:36.551699 7fc0e718c6f0 journal read_entry 133296128 : seq 14986 393 bytes
> > 2010-10-25 12:04:36.551709 7fc0e718c6f0 journal read_entry 133304320 : seq 14987 393 bytes
> > 2010-10-25 12:04:36.551719 7fc0e718c6f0 journal read_entry 133312512 : seq 14988 393 bytes
> > 2010-10-25 12:04:36.551729 7fc0e718c6f0 journal read_entry 133320704 : seq 14989 393 bytes
> > 2010-10-25 12:04:36.551739 7fc0e718c6f0 journal read_entry 133328896 : seq 14990 393 bytes
> > 2010-10-25 12:04:36.551749 7fc0e718c6f0 journal read_entry 133337088 : seq 14991 393 bytes
> > 2010-10-25 12:04:36.551759 7fc0e718c6f0 journal read_entry 133345280 : seq 14992 393 bytes
> > 2010-10-25 12:04:36.551769 7fc0e718c6f0 journal read_entry 133353472 : seq 14993 393 bytes
> > 2010-10-25 12:04:36.553643 7fc0e718c6f0 journal read_entry 133361664 : seq 14994 393 bytes
> > 2010-10-25 12:04:36.553657 7fc0e718c6f0 journal read_entry 133369856 : seq 14995 393 bytes
> > 2010-10-25 12:04:36.553668 7fc0e718c6f0 journal read_entry 133378048 : seq 14996 393 bytes
> > 2010-10-25 12:04:36.553678 7fc0e718c6f0 journal read_entry 133386240 : seq 14997 393 bytes
> > 2010-10-25 12:04:36.553688 7fc0e718c6f0 journal read_entry 133394432 : seq 14998 393 bytes
> > 2010-10-25 12:04:36.553698 7fc0e718c6f0 journal read_entry 133402624 : seq 14999 393 bytes
> > 2010-10-25 12:04:36.553708 7fc0e718c6f0 journal read_entry 133410816 : seq 15000 393 bytes
> > 2010-10-25 12:04:36.553718 7fc0e718c6f0 journal read_entry 133419008 : seq 15001 393 bytes
> > 2010-10-25 12:04:36.553728 7fc0e718c6f0 journal read_entry 133427200 : seq 15002 393 bytes
> > 2010-10-25 12:04:36.553754 7fc0e718c6f0 journal read_entry 133435392 : seq 15003 393 bytes
> > 2010-10-25 12:04:36.553765 7fc0e718c6f0 journal read_entry 133443584 : seq 15004 393 bytes
> > 2010-10-25 12:04:36.553775 7fc0e718c6f0 journal read_entry 133451776 : seq 15005 393 bytes
> > 2010-10-25 12:04:36.553785 7fc0e718c6f0 journal read_entry 133459968 : seq 15006 393 bytes
> > 2010-10-25 12:04:36.553794 7fc0e718c6f0 journal read_entry 133468160 : seq 15007 393 bytes
> > 2010-10-25 12:04:36.553804 7fc0e718c6f0 journal read_entry 133476352 : seq 15008 393 bytes
> > 2010-10-25 12:04:36.553814 7fc0e718c6f0 journal read_entry 133484544 : seq 15009 393 bytes
> > 2010-10-25 12:04:36.555677 7fc0e718c6f0 journal read_entry 133492736 : seq 15010 393 bytes
> > 2010-10-25 12:04:36.555696 7fc0e718c6f0 journal read_entry 133500928 : seq 15011 393 bytes
> > 2010-10-25 12:04:36.555707 7fc0e718c6f0 journal read_entry 133509120 : seq 15012 393 bytes
> > 2010-10-25 12:04:36.555718 7fc0e718c6f0 journal read_entry 133517312 : seq 15013 393 bytes
> > 2010-10-25 12:04:36.555728 7fc0e718c6f0 journal read_entry 133525504 : seq 15014 393 bytes
> > 2010-10-25 12:04:36.555738 7fc0e718c6f0 journal read_entry 133533696 : seq 15015 393 bytes
> > 2010-10-25 12:04:36.555748 7fc0e718c6f0 journal read_entry 133541888 : seq 15016 393 bytes
> > 2010-10-25 12:04:36.555758 7fc0e718c6f0 journal read_entry 133550080 : seq 15017 393 bytes
> > 2010-10-25 12:04:36.555768 7fc0e718c6f0 journal read_entry 133558272 : seq 15018 393 bytes
> > 2010-10-25 12:04:36.555778 7fc0e718c6f0 journal read_entry 133566464 : seq 15019 393 bytes
> > 2010-10-25 12:04:36.555788 7fc0e718c6f0 journal read_entry 133574656 : seq 15020 393 bytes
> > 2010-10-25 12:04:36.590950 7fc0e718c6f0 osd79 0 boot
> > *** Caught signal (ABRT) ***
> >  ceph version 0.23~rc (commit:a869b35abdab37bd4505f435bf0f7ab1860b28cc)
> >  1: (sigabrt_handler(int)+0x4a) [0x6156ea]
> >  2: /lib64/libc.so.6 [0x7fc0e5d652d0]
> >  3: (gsignal()+0x35) [0x7fc0e5d65265]
> >  4: (abort()+0x110) [0x7fc0e5d66d10]
> >  5: (__gnu_cxx::__verbose_terminate_handler()+0x114) [0x7fc0e65dbcb4]
> >  6: /usr/lib64/libstdc++.so.6 [0x7fc0e65d9db6]
> >  7: /usr/lib64/libstdc++.so.6 [0x7fc0e65d9de3]
> >  8: /usr/lib64/libstdc++.so.6 [0x7fc0e65d9eca]
> >  9: (ceph::buffer::list::iterator::copy(unsigned int, char*)+0x178) [0x467028]
> >  10: (PG::read_state(ObjectStore*)+0x424) [0x558f44]
> >  11: (OSD::load_pgs()+0x13a) [0x4e1dca]
> >  12: (OSD::init()+0x393) [0x503b43]
> >  13: (main()+0x10c8) [0x463478]
> >  14: (__libc_start_main()+0xf4) [0x7fc0e5d52994]
> >  15: (__gxx_personality_v0()+0x209) [0x462259]
> > *** Caught signal (SEGV) ***
> >  ceph version 0.23~rc (commit:a869b35abdab37bd4505f435bf0f7ab1860b28cc)
> >  1: (sigsegv_handler(int)+0x4a) [0x61591a]
> >  2: /lib64/libc.so.6 [0x7fc0e5d652d0]
> >
> > # gdb cosd
> > (gdb) l *0x467028
> > 0x467028 is in ceph::buffer::list::iterator::copy(unsigned int, char*) (./include/buffer.h:471).
> > 466         const char *raw_c_str() const { assert(_raw); return _raw->data; }
> > 467         unsigned raw_length() const { assert(_raw); return _raw->len; }
> > 468         int raw_nref() const { assert(_raw); return _raw->nref.read(); }
> > 469
> > 470         void copy_out(unsigned o, unsigned l, char *dest) const {
> > 471           assert(_raw);
> > 472           if (!((o >= 0 && o <= _len) &&
> > 473                 (l >= 0 && o+l <= _len)))
> > 474             throw end_of_buffer();
> > 475           memcpy(dest, c_str()+o, l);
> > (gdb) l *0x558f44
> > 0x558f44 is in PG::read_state(ObjectStore*) (./include/encoding.h:80).
> > 75          v = e;                                                              \
> > 76        }
> > 77
> > 78      WRITE_INTTYPE_ENCODER(uint64_t, le64)
> > 79      WRITE_INTTYPE_ENCODER(int64_t, le64)
> > 80      WRITE_INTTYPE_ENCODER(uint32_t, le32)
> > 81      WRITE_INTTYPE_ENCODER(int32_t, le32)
> > 82      WRITE_INTTYPE_ENCODER(uint16_t, le16)
> > 83      WRITE_INTTYPE_ENCODER(int16_t, le16)
> > 84
> > (gdb) l *0x4e1dca
> > 0x4e1dca is in OSD::load_pgs() (./osd/osd_types.h:123).
> > 118     // placement group id
> > 119     struct pg_t {
> > 120       struct ceph_pg v;
> > 121
> > 122       pg_t() { memset(&v, 0, sizeof(v)); }
> > 123       pg_t(const pg_t& o) { v = o.v; }
> > 124       pg_t(ps_t seed, int pool, int pref) {
> > 125         v.ps = seed;
> > 126         v.pool = pool;
> > 127         v.preferred = pref;   // hack: avoid negative.
> > (gdb) l *0x503b43
> > 0x503b43 is in OSD::init() (osd/OSD.cc:504).
> > 499       }
> > 500
> > 501       // load up pgs (as they previously existed)
> > 502       load_pgs();
> > 503
> > 504       dout(2) << "superblock: i am osd" << superblock.whoami << dendl;
> > 505       assert_warn(whoami == superblock.whoami);
> > 506       if (whoami != superblock.whoami) {
> > 507         dout(0) << "wtf, superblock says osd" << superblock.whoami << " but i am osd" << whoami << dendl;
> > 508         return -EINVAL;
> >
> >
> > -- Jim
> >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> >
> 



From: =?UTF-8?B?6IKW5YWI6Zye?= <xianxiaxiao@ubuntukylin.com>
Subject: Re: location-aware file placement in Ceph
Date: Sat, 01 Mar 2014 10:48:16 +0800
Message-ID: <53114A70.4090003@ubuntukylin.com>
References: <530F3CAC.2040504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m59-178.qiye.163.com ([123.58.178.59]:60820 "EHLO
	m59-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752040AbaCACy5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 28 Feb 2014 21:54:57 -0500
In-Reply-To: <530F3CAC.2040504@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zhongliang Zhao <zhaozhongliang@gmail.com>, ceph-devel@vger.kernel.org

May be able to meet your needs through rbd.

You can create multiple rules,and then specify a different pool to use =
a=20
different ruleset.
Then create multiple block images, and Specify image to different pools=
=2E
create  file system on the block device and mount file system on=20
different positions,so that the different location of the file can use=20
different ruleset

-------
xianxia xiao



=E4=BA=8E 2014/2/27 21:25, Zhongliang Zhao =E5=86=99=E9=81=93:
> Dear all,
>
> As new to ceph, may I ask in the crush algorithm, is there a way to=20
> configure where the file to be stored, not randomly.
> My requirement is to place the files that within the same=20
> location(within a geographic area), into the same OSD, instead of=20
> randomly placing them seperately.
>
> I guess crush may support this. But to do this, I just have to=20
> configure some parameters in some ceph commands? or I have to modify=20
> the ceph crush algorithm and re-compile ceph?
>
> Many thanks for any helpful pointers.
>
> Cheers, Giovanni
> --=20
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

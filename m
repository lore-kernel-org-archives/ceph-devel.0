From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Some problem of ceph and radosgw
Date: Sun, 26 Sep 2010 20:49:13 +0200
Message-ID: <1285526953.5460.5.camel@wido-laptop.pcextreme.nl>
References: <AANLkTimTkphpGFqZ1R46CiJ5UFG394FQ=uy6SjiLXqho@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:39751 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757160Ab0IZStQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 26 Sep 2010 14:49:16 -0400
In-Reply-To: <AANLkTimTkphpGFqZ1R46CiJ5UFG394FQ=uy6SjiLXqho@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: cang lin <fwdflywl@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi,

The OSD performance you are seeing is not network related, it's due to
your hardware/drivers.

Do you have a journal enabled?

And could you try to do a benchmark with:

hdparm -tT /dev/sdx

Where /dev/sdx is the disk where your data is on. This will give you the
read performance.

You could also do some write tests with dd, for example:

dd if=/dev/zero of=1GB.bin bs=1024k count=1024 conv=sync

Run this in your OSD data directory.

About the RADOS Gateway, which libs3 are you using? I would recommend:
git://github.com/wido/libs3.git

Yesterday I found a bug in the RADOS Gateway, it might be that you are
also hitting it. Could you upload your error_log (Apache) somewhere or
attach it? And please set RGW_LOG_LEVEL to 20 to get as much information
as possible.

Thanks!

Wido


On Sun, 2010-09-26 at 18:24 +0800, cang lin wrote:
> Write speed of osd is very slow.
> 
> Test osd1 according to
> http://ceph.newdream.net/wiki/Troubleshooting#OSD performance
> 
> # ceph osd tell 1 bench
> 10.09.23_21:33:06.774427 mon <- [osd,tell,1,bench]
> 10.09.23_21:33:06.775481 mon0 -> 'ok' (0)
> 
> log 10.09.23_21:39:09.949601 osd1 ???.???.248.176:6801/25594 1 : [INF]
> bench: wrote 1024 MB in blocks of 4096 KB in 363.165841 sec at 2887
> KB/sec
> 
> Test of osd0
> 
> # ceph osd tell 0 bench
> 10.09.23_21:39:58.046587 mon <- [osd,tell,0,bench]
> 10.09.23_21:39:58.047716 mon0 -> 'ok' (0)
> 
> log 10.09.23_21:45:17.907473 osd0 ???.???.248.177:6801/13222 1 : [INF]
> bench: wrote 1024 MB in blocks of 4096 KB in 319.851284 sec at 3278
> KB/sec
> 
> The network is tested to be ok by iperf. mds, mon, osd0  and other 3
> osd(osd02,osd03,osd04) are running on the same host.The standby mds
> and osd1 are running on other host. Journal is a file and the size of
> it is about 100MB.
> 
> Error occurs when test radoswg
> 
> Config radosgw,apache web server,fastcgi module on the host which is
> running mon,mds and ods. Can use radosgw_admin to generate UserID and
> SecretKey,libs3 throw error when use s3 -u.
> 
> web1@ceph01:~$ s3 -u create alpha
> ERROR: ConnectionFailed
> 
> web1@ceph01:~$ s3 -u list
> ERROR: ConnectionFailed
> 
> Config radosgw,apache web server,fastcgi module on another host. Can
> use radosgw_admin to generate UserID and Secret Key,but error occurs
> when create bucket.
> 
> web1@cl0:~$ s3 -u create alpha
> ERROR: XmlParseFailure
> 
> But list works fine.
> 
> web1@cl0:~$ s3 -u list
>                 Bucket                                 Created
> --------------------------------------------------------  --------------------
> web1@c01:~$
> 
> How the solve the problem?
> 
> Thanks!
> Lin
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


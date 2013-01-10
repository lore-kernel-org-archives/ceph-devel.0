From: Gregory Farnum <greg@inktank.com>
Subject: Re: osd down (for 2 about 2 minutes) error after adding a new host to
 my cluster
Date: Thu, 10 Jan 2013 10:32:25 -0800
Message-ID: <CAPYLRzj=QOiXjGB=L8XsfNbHhfbt-WRRH=La1-SxVB_nX8Zr-w@mail.gmail.com>
References: <CABYiri8PnWR=LNPuR1bqpuPGp55diHYPsAhdUtd7dNC9=UJTRQ@mail.gmail.com>
	<alpine.DEB.2.00.1211290833290.30450@cobra.newdream.net>
	<CABYiri_QS0C1gxygOEW58J7+BQyzjt5X8KJA3Hh8XPGWhnHtRA@mail.gmail.com>
	<50B80600.1000304@inktank.com>
	<1354237947.86472.YahooMailNeo@web121901.mail.ne1.yahoo.com>
	<1354238575.90788.YahooMailNeo@web121904.mail.ne1.yahoo.com>
	<1357591756.80653.YahooMailNeo@web121903.mail.ne1.yahoo.com>
	<1357592421.16299.YahooMailNeo@web121902.mail.ne1.yahoo.com>
	<D5D52DC203EC4D6BBD7A2DF4753B2C2C@inktank.com>
	<1357680673.72602.YahooMailNeo@web121904.mail.ne1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f44.google.com ([209.85.216.44]:45877 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755193Ab3AJSc0 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Jan 2013 13:32:26 -0500
Received: by mail-qa0-f44.google.com with SMTP id z4so1938243qan.3
        for <ceph-devel@vger.kernel.org>; Thu, 10 Jan 2013 10:32:25 -0800 (PST)
In-Reply-To: <1357680673.72602.YahooMailNeo@web121904.mail.ne1.yahoo.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Isaac Otsiabah <zmoo76b@yahoo.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Jan 8, 2013 at 1:31 PM, Isaac Otsiabah <zmoo76b@yahoo.com> wrote:
>
>
> Hi Greg, it appears to be a timing issue because with the flag (debug ms=1) turned on, the system ran slower and became harder to fail. I ran it several times and finally got it to fail on (osd.0) using default crush map. The attached tar file contains log files  for all components on g8ct plus the ceph.conf.
>
> I started with a 1-node cluster on host g8ct (osd.0, osd.1, osd.2)  and then added host g13ct (osd.3, osd.4, osd.5)
>
>
>
>  id    weight  type name       up/down reweight
> -1      6       root default
> -3      6               rack unknownrack
> -2      3                       host g8ct
> 0       1                               osd.0   down    1
> 1       1                               osd.1   up      1
> 2       1                               osd.2   up      1
> -4      3                       host g13ct
> 3       1                               osd.3   up      1
> 4       1                               osd.4   up      1
> 5       1                               osd.5   up      1
>
>
>
> The error messages are in ceph.log and ceph-osd.0.log:
>
> ceph.log:2013-01-08 05:41:38.080470 osd.0 192.168.0.124:6801/25571 3 : [ERR] map e15 had wrong cluster addr (192.168.0.124:6802/25571 != my 192.168.1.124:6802/25571)
> ceph-osd.0.log:2013-01-08 05:41:38.080458 7f06757fa710  0 log [ERR] : map e15 had wrong cluster addr (192.168.0.124:6802/25571 != my 192.168.1.124:6802/25571)

Thanks. I had a brief look through these logs on Tuesday and want to
spend more time with them because they have some odd stuff in them. It
*looks* like the OSD is starting out using a single IP for both the
public and cluster networks and then switching over at some point,
which is...odd.
Knowing more details about how your network is actually set up would
be very helpful.
-Greg

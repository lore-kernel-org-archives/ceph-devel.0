From: Gregory Farnum <greg@inktank.com>
Subject: Re: Question about configuration
Date: Thu, 10 Jan 2013 16:55:00 -0800
Message-ID: <CAPYLRzhrPaRpPwJ=m5G51-KpY_jev2fn_gXaXEC6OdcAEDXfcA@mail.gmail.com>
References: <20130110.163912.203671451.yasu@soe.ucsc.edu>
	<CAPYLRzhZr81ko3QgC1oGXs_12-C6z-EVmuf3k47Ej3j8P_T0AA@mail.gmail.com>
	<20130110.165145.102237146.yasu@soe.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f180.google.com ([209.85.216.180]:60322 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753156Ab3AKAzB convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Jan 2013 19:55:01 -0500
Received: by mail-qc0-f180.google.com with SMTP id v28so782456qcm.25
        for <ceph-devel@vger.kernel.org>; Thu, 10 Jan 2013 16:55:01 -0800 (PST)
In-Reply-To: <20130110.165145.102237146.yasu@soe.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yasuhiro Ohara <yasu@soe.ucsc.edu>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Jan 10, 2013 at 4:51 PM, Yasuhiro Ohara <yasu@soe.ucsc.edu> wro=
te:
>
> Hi, Greg,
>
> When I went through the Ceph document, I could find the description
> about /etc/init.d only, so it is still the easiest for me.
> Is there documentation on other (upstart?) system or do I need to
> learn those system ? Or just letting me know how to install the
> resource file (for Ceph in upstart) might work for me.

There isn't really any documentation right now and if you started off
with sysvinit it's probably easiest to continue that way. It will work
with that system too; it's just that if you run "sudo service ceph -a
start" then it's going to go and turn on all the daemons listed in its
local ceph.conf.
-Greg

>
> Thanks.
>
> regards,
> Yasu
>
> From: Gregory Farnum <greg@inktank.com>
> Subject: Re: Question about configuration
> Date: Thu, 10 Jan 2013 16:43:59 -0800
> Message-ID: <CAPYLRzhZr81ko3QgC1oGXs_12-C6z-EVmuf3k47Ej3j8P_T0AA@mail=
=2Egmail.com>
>
>> On Thu, Jan 10, 2013 at 4:39 PM, Yasuhiro Ohara <yasu@soe.ucsc.edu> =
wrote:
>>>
>>> Hi,
>>>
>>> What will happen when constructing a cluster of 10 host,
>>> but the hosts are gradually removed from the cluster
>>> one by one (in each step waiting Ceph status to become healthy),
>>> and reaches eventually to, say, 3 hosts ?
>>>
>>> In other words, is there any problem with having 10 osd configurati=
on
>>> in the ceph.conf, but actually only 3 is up (the 7 are down and out=
) ?
>>
>> If you're not using the /etc/init.d ceph script to start up everythi=
ng
>> with the -a option, this will work just fine.
>>
>>>
>>> I assume that if the size of the replication is 3, we can turn off
>>> 2 osds at each time, and Ceph can recover itself to the healthy sta=
te.
>>> Is it the case ?
>>
>> Yeah, that should work fine. You might consider just marking OSDs
>> "out" two at a time and not actually killing them until the cluster
>> has become quiescent again, though =97 that way they can participate=
 as
>> a source for recovery.
>> -Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Robert LeBlanc <robert@leblancnet.us>
Subject: Re: throttles
Date: Tue, 13 Oct 2015 10:27:36 -0600
Message-ID: <CAANLjFoxOoKNSirEgk1WhupLY-W5_ReWJx2yKGE3q=bEm=yKag@mail.gmail.com>
References: <BC97738F8E7C8742BABED7F06FB9DF91925201E3@SATLEXDAG01.amd.com>
	<alpine.DEB.2.00.1510130541070.6589@cobra.newdream.net>
	<BC97738F8E7C8742BABED7F06FB9DF919252061D@SATLEXDAG01.amd.com>
	<755F6B91B3BE364F9BCA11EA3F9E0C6F31741523@SACMBXIP02.sdcorp.global.sandisk.com>
	<BC97738F8E7C8742BABED7F06FB9DF9192520646@SATLEXDAG01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f43.google.com ([209.85.213.43]:33286 "EHLO
	mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753051AbbJMQ1h (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Oct 2015 12:27:37 -0400
Received: by vkaw128 with SMTP id w128so13618826vka.0
        for <ceph-devel@vger.kernel.org>; Tue, 13 Oct 2015 09:27:36 -0700 (PDT)
In-Reply-To: <BC97738F8E7C8742BABED7F06FB9DF9192520646@SATLEXDAG01.amd.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Deneau, Tom" <tom.deneau@amd.com>
Cc: Somnath Roy <Somnath.Roy@sandisk.com>, Sage Weil <sage@newdream.net>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

In my experience with throttles, we had to restart the OSD, the admin
socket would not apply the change to a running OSD.
- ----------------
Robert LeBlanc
PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1


On Tue, Oct 13, 2015 at 9:59 AM, Deneau, Tom  wrote:
> I remember previously there were some options that could be reset
> thru the admin socket and some that required an osd restart.
> Do the ones below require an osd restart?
>
> -- Tom
>
>> -----Original Message-----
>> From: Somnath Roy [mailto:Somnath.Roy@sandisk.com]
>> Sent: Tuesday, October 13, 2015 10:57 AM
>> To: Deneau, Tom; Sage Weil
>> Cc: ceph-devel@vger.kernel.org
>> Subject: RE: throttles
>>
>> BTW, you can completely turn off these throttles ( other than the
>> filestore throttle ) by setting the value to 0.
>>
>> Thanks & Regards
>> Somnath
>>
>> -----Original Message-----
>> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
>> owner@vger.kernel.org] On Behalf Of Deneau, Tom
>> Sent: Tuesday, October 13, 2015 8:55 AM
>> To: Sage Weil
>> Cc: ceph-devel@vger.kernel.org
>> Subject: RE: throttles
>>
>> > -----Original Message-----
>> > From: Sage Weil [mailto:sage@newdream.net]
>> > Sent: Tuesday, October 13, 2015 7:44 AM
>> > To: Deneau, Tom
>> > Cc: ceph-devel@vger.kernel.org
>> > Subject: Re: throttles
>> >
>> > On Mon, 12 Oct 2015, Deneau, Tom wrote:
>> > > Looking at the perf counters on my osds, I see wait counts for the
>> > > following throttle related perf counters:  (This is from trying to
>> > > benchmark using multiple rados bench client processes).
>> > >
>> > >    throttle-filestore_bytes
>> >
>> > OPTION(filestore_queue_max_ops, OPT_INT, 50)
>> > OPTION(filestore_queue_max_bytes, OPT_INT, 100 << 20)
>> >
>> > >    throttle-msgr_dispatch_throttler-client
>> >
>> > OPTION(ms_dispatch_throttle_bytes, OPT_U64, 100 << 20)
>> >
>> > >    throttle-osd_client_bytes
>> > >    throttle-osd_client_messages
>> >
>> > OPTION(osd_client_message_size_cap, OPT_U64, 500*1024L*1024L) //
>> > client data allowed in-memory (in bytes)
>> > OPTION(osd_client_message_cap, OPT_U64, 100)              // num client
>> > messages allowed in-memory
>> >
>> > > What are the config variables that would allow me to experiment with
>> > these throttle limits?
>> > > (When I look at the output from --admin-daemon osd.xx.asok config
>> > > show, it's not clear which items these correspond to).
>> >
>> > These are all involved in slowing down clients to the rate of the
>> > storage...
>> >
>> > sage
>>
>> Thanks, Sage and Somnath --
>>
>> The reason I was interested is that I am seeing a levelling off of read
>> bandwidth while the sar data shows we are not anywhere near the limits for
>> cpu utilization (client or osd node) nor for disk utilization (no disk
>> above 40% utilization) nor for network utilization (this is with 10Gig
>> Ethernet).
>>
>> -- Tom
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org More majordomo info at
>> http://vger.kernel.org/majordomo-info.html
>>
>> ________________________________
>>
>> PLEASE NOTE: The information contained in this electronic mail message is
>> intended only for the use of the designated recipient(s) named above. If
>> the reader of this message is not the intended recipient, you are hereby
>> notified that you have received this message in error and that any review,
>> dissemination, distribution, or copying of this message is strictly
>> prohibited. If you have received this communication in error, please
>> notify the sender by telephone or e-mail (as shown above) immediately and
>> destroy any and all copies of this message in your possession (whether
>> hard copies or electronically stored copies).
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-----BEGIN PGP SIGNATURE-----
Version: Mailvelope v1.2.0
Comment: https://www.mailvelope.com

wsFcBAEBCAAQBQJWHTD0CRDmVDuy+mK58QAAEZIQAMdBRDXIfovmeHhEpB/A
v7+gq/2D1lh7G45OkDLmpwJM0b0KmTqZIOJiVylfzqGZlxQAFy+nSOp9cZi9
8dUc7ybV3U7fHxXlOmotXJAHf3GsOBccIcyKhSW8Z6h/pfUyCAOQLCU2FIcE
NN8latUJZE4WJMjyvcoeQNsrVDahPORznXXSZ1+yzkyBBdopKkbMbz7qk1Wu
eH1IwfIEcqND9cE59wMM4E+EtRH/iiJE9JibRz9TI8Zo40RgWdrlYd0REbOC
STtbIw8LderkXmlcyYQfiOWc+fRGkcgac2Oqybdhpl2wEr24KnkaCyJl8RRD
p0MtU4fNJ0G7L7/fZW+bMb0FjyjKpXBLrBzkTQmlI1rxN8lhN7xiPnXQcjUF
qr5Gu1in/9rC6Nxr5iyvat3UhcL8ggGl6KAnVh5AvTsyWgh2DRs5IH7WfYMz
f7HgHVcXNK3NGar7bs22/mJmsLbFwfBIe03LYssv+y0kic+HpSii4zCVi0+7
JAYS37qca8lE17Z4LLEEf6XbzVkwhgKAG4sBjzqdded0qaxvNUaXe4GBKxeM
Dk09VHcdlGLB+2Db5IWy7ynl97ljwSPcbNvaQtKDUfSWVgvbqIXxmhBEa0/P
RWWf7OhGYlVNPlNdyaaaU0Fd0n4YiV9kTfS+70G9uGzKA4viybQMfJRXpROQ
oCGR
=IJGd
-----END PGP SIGNATURE-----

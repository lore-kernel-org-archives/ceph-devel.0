From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: Logging
Date: Mon, 18 Apr 2011 11:41:18 -0700
Message-ID: <BANLkTimPP2epqVTPwiXMubB_q_Rf+3Ro4w@mail.gmail.com>
References: <4DAB77FD.4010804@provocation.net>
	<BANLkTinntanBQLag+8hC+FSfpxz8iib1uA@mail.gmail.com>
	<4DAC0EE7.4080001@provocation.net>
	<BANLkTikCO-pgBfNtvpMVn5HEG2ujhsSgxQ@mail.gmail.com>
	<4DAC8021.6000701@provocation.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:62527 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754844Ab1DRSlT convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Apr 2011 14:41:19 -0400
Received: by bwz15 with SMTP id 15so4076532bwz.19
        for <ceph-devel@vger.kernel.org>; Mon, 18 Apr 2011 11:41:18 -0700 (PDT)
In-Reply-To: <4DAC8021.6000701@provocation.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zenon Panoussis <oracle@provocation.net>
Cc: ceph-devel@vger.kernel.org

I added "Mount the partition you are logging to using noatime" as a
"tip" on http://ceph.newdream.net/wiki/Cluster_configuration

cheers,
Colin


On Mon, Apr 18, 2011 at 11:17 AM, Zenon Panoussis
<oracle@provocation.net> wrote:
>
>
> On 04/18/2011 07:16 PM, Colin McCabe wrote:
>
>> If you'd like to measure performance without logging, first set all
>> the debug levels to 0. You should be able to do this, at least in
>> head-of-line, with this:
>
>> Then disable all the log sinks with this:
>
> Thanks, that's the part I was missing.
>
> In the meanwhile I found a major bottleneck in my cluster, namely the=
 fact
> that I had mounted the ext4 partitions that hold the stores with atim=
e
> enabled. I should have thought of it earlier...
>
> Z
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

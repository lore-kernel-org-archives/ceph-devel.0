From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: Logging
Date: Mon, 18 Apr 2011 15:25:55 -0700
Message-ID: <BANLkTi=MsnZnmZuace=bzRhGo8sP2QjKLw@mail.gmail.com>
References: <4DAB77FD.4010804@provocation.net>
	<BANLkTinntanBQLag+8hC+FSfpxz8iib1uA@mail.gmail.com>
	<4DAC0EE7.4080001@provocation.net>
	<BANLkTikCO-pgBfNtvpMVn5HEG2ujhsSgxQ@mail.gmail.com>
	<4DAC8021.6000701@provocation.net>
	<BANLkTimPP2epqVTPwiXMubB_q_Rf+3Ro4w@mail.gmail.com>
	<4DACA57E.2040609@provocation.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:33240 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752203Ab1DRWZ5 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Apr 2011 18:25:57 -0400
Received: by bwz15 with SMTP id 15so4248725bwz.19
        for <ceph-devel@vger.kernel.org>; Mon, 18 Apr 2011 15:25:55 -0700 (PDT)
In-Reply-To: <4DACA57E.2040609@provocation.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zenon Panoussis <oracle@provocation.net>
Cc: ceph-devel@vger.kernel.org

On Mon, Apr 18, 2011 at 1:56 PM, Zenon Panoussis <oracle@provocation.ne=
t> wrote:
>
> On 04/18/2011 08:41 PM, Colin McCabe wrote:
>
>> I added "Mount the partition you are logging to using noatime" as a
>> "tip" on http://ceph.newdream.net/wiki/Cluster_configuration
>
> Aha, and I had put a word about noatime for the OSD partition in
> http://ceph.newdream.net/wiki/Mounting_the_file_system . Obviously it=
 doesn't
> make much of a difference on writes, but it makes a HUGE difference o=
n reads.
>
> Z

Oh yeah. mtime and ctime are the relevant things for writing (i.e.
logging.) Well, I feel dumb now.

I'm sure there are other optimizations you could do for the logging par=
tition.

I'm curious how much you saved by disabling logging. Also, how are you
measuring performance?

sincerely,
Colin


>
>
>
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

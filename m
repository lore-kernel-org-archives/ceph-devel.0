From: djlee064 <djlee064@gmail.com>
Subject: Re: MDS configuration
Date: Sun, 12 Jun 2011 20:41:56 +1200
Message-ID: <BANLkTikbpzbuwyBE++amnJj0eN=4k626aA@mail.gmail.com>
References: <4DF266B9.3040407@ufm.su>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:37542 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752341Ab1FLIl6 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 12 Jun 2011 04:41:58 -0400
Received: by wwk4 with SMTP id 4so1819716wwk.1
        for <ceph-devel@vger.kernel.org>; Sun, 12 Jun 2011 01:41:56 -0700 (PDT)
In-Reply-To: <4DF266B9.3040407@ufm.su>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fyodor Ustinov <ufm@ufm.su>
Cc: ceph-devel@vger.kernel.org

based on the empirical measurement, starting with a set of (real)
number of files, focusing mainly on small-files. and found some rough
relationship,
all filesets with same dist. i.e., ~80% <4MB file, mostly small, all 1x=
=2E replc.
=46or MDS RAM:

You need about:
0.6GB RAM to store 0.03million files (fileset vol. 1.2TB)
1.2GB to store=A0 0.065million files (fileset vol. 2.4TB)
1.8GB to store 0.13million files=A0 (fileset vol. 4.8TB)

ratio of no.files per GB fortunately increases, (i.e., 0.07million per
GB for the 0.13million files), hopefully per-GB will support
0.1million files as more files are stored.
then, 18GB =3D 1.8million files,
180GB =3D 18million
1800GB=3D 180million (this is about 6.64PB),

So to support that amount,, we need 100 MDS nodes with 18GB purely for
cmds, incl mem for OS, etc, maybe 20-24GB per node.

Cheers

On Sat, Jun 11, 2011 at 06:47, Fyodor Ustinov <ufm@ufm.su> wrote:
>
> Hi!
>
> Which configuration would you recommended for cluster with 50-80 mill=
ion files?
>
> WBR,
> =A0 =A0Fyodor.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Oliver Francke <Oliver.Francke@filoo.de>
Subject: Re: OSD memory leak when scrubbing [0.56.6]
Date: Tue, 21 May 2013 17:34:17 +0200
Message-ID: <519B93F9.1010606@filoo.de>
References: <519B9196.5090402@filoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-1.de-punkt.de ([93.190.64.237]:37383 "EHLO
	mail-1.de-punkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754105Ab3EUPeT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 May 2013 11:34:19 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail-1.de-punkt.de (Postfix) with ESMTP id 9536F3A392
	for <ceph-devel@vger.kernel.org>; Tue, 21 May 2013 17:34:17 +0200 (CEST)
Received: from mail-1.de-punkt.de ([127.0.0.1])
	by localhost (mail-10.de-punkt.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FIVmhHNgIU45 for <ceph-devel@vger.kernel.org>;
	Tue, 21 May 2013 17:34:17 +0200 (CEST)
Received: from [192.168.1.152] (p4FECEC7E.dip0.t-ipconnect.de [79.236.236.126])
	(Authenticated sender: oliver.francke@filoo.de)
	by mail-1.de-punkt.de (Postfix) with ESMTPSA id 69A1A3A249
	for <ceph-devel@vger.kernel.org>; Tue, 21 May 2013 17:34:17 +0200 (CEST)
In-Reply-To: <519B9196.5090402@filoo.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Uhm,

to be most correct... there was a follow-up even with version 0.56 ;)

On 05/21/2013 05:24 PM, Oliver Francke wrote:
> Well,
>
> subject seems familiar, version was 0.48.3 in the last mail.
>
> Some more of the story. Before successful upgrade to latest bobtail=20
> everything with regards to scrubbing was disabled.
> That is via:
>     ceph osd tell \* injectargs '--osd-max-scrubs 0'
>
> We are running fine now since 9th of may. Fine means though, not have=
=20
> ran any scrubbing for ages.
> This morning I re-started scrubbing. After a couple of hours I=20
> detected the first OSD's eating up memory.
> Top-scorer was running with 23GiB rss. After stopping scrubbing again=
=20
> there was no regain of memory.
>
> Not anyone else with perhaps large pg's experiencing such behaviour?
>
> Any advice on how to proceed?
>
> Thnx in advance,
>
> Oliver.
>


--=20

Oliver Francke

filoo GmbH
Moltkestra=DFe 25a
33330 G=FCtersloh
HRB4355 AG G=FCtersloh

Gesch=E4ftsf=FChrer: S.Grewing | J.Rehp=F6hler | C.Kunz

=46olgen Sie uns auf Twitter: http://twitter.com/filoogmbh

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

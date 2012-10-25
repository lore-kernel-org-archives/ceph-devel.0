From: Gregory Farnum <greg@inktank.com>
Subject: Re: Number of object replicas
Date: Thu, 25 Oct 2012 13:17:54 -0700
Message-ID: <CAPYLRzgc3S3iEqJLbPTPE6G4pAVtG=HnjT7iF_UCOYAt29ji0w@mail.gmail.com>
References: <20121025210516.122513f4.ctpm@ist.utl.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:34425 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030240Ab2JYUR4 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Oct 2012 16:17:56 -0400
Received: by mail-la0-f46.google.com with SMTP id h6so1937901lag.19
        for <ceph-devel@vger.kernel.org>; Thu, 25 Oct 2012 13:17:54 -0700 (PDT)
In-Reply-To: <20121025210516.122513f4.ctpm@ist.utl.pt>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?Cl=E1udio_Martins?= <ctpm@ist.utl.pt>, John Wilkins <john.wilkins@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Thu, Oct 25, 2012 at 1:05 PM, Cl=E1udio Martins <ctpm@ist.utl.pt> wr=
ote:
>
>  Hello,
>
>  The text at
>
> http://ceph.com/docs/master/cluster-ops/pools/
>
>  appears to have a slight inconsistency. At the top it says
>
> "Replicas: You can set the desired number of copies/replicas of an ob=
ject. A typical configuration stores an object and one additional copy =
(i.e., size =3D 2), but you can determine the number of copies/replicas=
=2E"
>
>
>  But on the last section, at the bottom of the page, one reads:
>
> "Ceph will list the pools, with the rep size attribute highlighted. B=
y default, Ceph creates two replicas of an object for a total of three =
copies."
>
>
>  Which does not seem to be in agreement with the 1st paragraph on tha=
t
> page or, at least, is ambiguous.

You're right. The correct version is the first one =97 the default size
is two, meaning two copies of the data total.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

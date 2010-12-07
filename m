From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: Dependence on libcrypto++
Date: Tue, 7 Dec 2010 09:54:05 -0800
Message-ID: <AANLkTikvXVh0i1aVE=0sJHzWRNmPeeuh8SpKTm=-skck@mail.gmail.com>
References: <1291739112.4879.366.camel@sale659.sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:65448 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750819Ab0LGRyH convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Dec 2010 12:54:07 -0500
Received: by wyb28 with SMTP id 28so164855wyb.19
        for <ceph-devel@vger.kernel.org>; Tue, 07 Dec 2010 09:54:06 -0800 (PST)
In-Reply-To: <1291739112.4879.366.camel@sale659.sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Dec 7, 2010 at 8:25 AM, Jim Schutt <jaschut@sandia.gov> wrote:
> Hi,
>
> Commit 15d8bdf3bf switched to libcrypto++ (AKA libcryptopp)
> for aes, rather than openssl.
>
> It appears that RedHat does not package this
> library for either Enterprise 5
> =A0http://ftp.redhat.com/pub/redhat/linux/enterprise/5Client/en/os/SR=
PMS/
> or Enterprise 6
> =A0http://ftp.redhat.com/pub/redhat/linux/enterprise/6Client/en/os/SR=
PMS/
>
> According to
> =A0http://www.cryptopp.com/wiki/Linux#Distributions_Offering_Crypto.2=
B.2B
> it's the only major distro that doesn't.
>
> So, what's the right thing to do? =A0Will it be feasible to
> fall back to openssl if libcryto++ isn't available?

=46rom what I can tell you can get currently the required rpm from rpmf=
orge:
http://packages.sw.be/cryptopp/

This is not supported officially by RH.
>
> Are there any RedHat employees on the list who can learn
> whether there is any chance that RedHat can package
> libcrypto++/libcryptopp?
>

If you (or anyone else that needs it for that matter) have a support
contract with RH you can try open a bugzilla request asking them to
pick it up. If we find it to be a real issue we might consider
switching to gnutls instead of libcrypto++, however, the issue there
is that we'd have to drop support to older distributions (as it didn't
export the required lower-level crypto functions until more recent
releases).

Thanks,
Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

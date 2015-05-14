From: Robert LeBlanc <robert@leblancnet.us>
Subject: Re: [Ceph-maintainers] statically allocated uid/gid for ceph
Date: Thu, 14 May 2015 10:20:51 -0600
Message-ID: <CAANLjFo0OKui4j9HVW7TaoOsSn3Dq+P0rPS0i6SG=8Za4Q1L1w@mail.gmail.com>
References: <alpine.DEB.2.00.1412061245410.18213@cobra.newdream.net>
	<5488919E.4090109@redhat.com>
	<alpine.DEB.2.00.1412101044300.22847@cobra.newdream.net>
	<5488FC46.5080106@suse.com>
	<alpine.DEB.2.00.1504131802400.32097@cobra.newdream.net>
	<552C9182.5030605@suse.com>
	<alpine.DEB.2.00.1504140819190.4469@cobra.newdream.net>
	<552D3C74.2000104@redhat.com>
	<87bnip2u10.fsf@meteor.durcheinandertal.bofh>
	<553E07C7.8030905@suse.com>
	<alpine.DEB.2.00.1504270901250.5458@cobra.newdream.net>
	<55549206.3040008@suse.com>
	<alpine.DEB.2.00.1505140906400.10788@cobra.newdream.net>
	<CAANLjFpgivwxMhFLy4OcCxnJ_k5ssORCUm2r+BgtU+LEPQmvPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:33507 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752373AbbENQUx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 May 2015 12:20:53 -0400
Received: by wgin8 with SMTP id n8so81109774wgi.0
        for <ceph-devel@vger.kernel.org>; Thu, 14 May 2015 09:20:52 -0700 (PDT)
In-Reply-To: <CAANLjFpgivwxMhFLy4OcCxnJ_k5ssORCUm2r+BgtU+LEPQmvPw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Tim Serong <tserong@suse.com>, Gaudenz Steinlin <gaudenz@debian.org>, Ken Dreyer <kdreyer@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, cjwatson@debian.org, ceph-maintainers@ceph.com, Steven Timm <timm@fnal.gov>, Owen Synge <osynge@suse.com>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

blagh HTML....

- ----------------
Robert LeBlanc
GPG Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1

On Thu, May 14, 2015 at 10:19 AM, Robert LeBlanc  wrote:
- -----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On Thu, May 14, 2015 at 10:08 AM, Sage Weil  wrote:
> The above should have no impact on other distros where a fixed UID/GID
> is already set in the package.

This sounds pretty reasonable to me!  Perhaps there can be a 'default'
(but still opt-in) uid that is reserved and won't conflict going forward,
but may conflict with legacy environments?  That at least minimizes
complexity/pain for fresh environments (which I suspect will
be the bulk of the install base)?


Since there is no guarantee, can we just default to the same UID/GID
that was received from Debian, or is there a known conflict in
RH/Cent/SUSE/etc?

 ----------------
Robert LeBlanc
GPG Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1

- -----BEGIN PGP SIGNATURE-----
Version: Mailvelope v0.13.1
Comment: https://www.mailvelope.com

wsFcBAEBCAAQBQJVVMr7CRDmVDuy+mK58QAAZtoQAL0geoqctooRrc+UaKLN
FbpfPRzF7wRyPbrwFJZV1jqJC1e4n1wVI/tRCaTNKOrlE/7e7AiEwPczwjD7
OLKXU1FJ/HNDXM5W0dbfBL8eauHziHo0ufK+odSAIuy+Tx21/Ll4+7FvrCj+
14pJ3wsNn4FHyDD7UpdJwYc+fK0QdqPrKzv8TJXxSE5RLNcRlem2FZxZn0MV
2xFaDdFDbBMZCTFM88wgU4ZewEIsJ12+nCHD8MgIIOrXSarK3sE1cIf0ihtu
WLD1hksOQtNGU2D3vSxYFYsFHIgwS/Cx/FuXggFmLQcK5FABlIS+UqveyY+e
lAcmkhA1auAcm0p1dp4GevKnfx5CxfcSGUEc7SQEa37/sNjplRTRPDGa/Pwg
8u989hTwf6acoCMhEp7P9i3MApeAEgYcQrd8fF5fK7nLr+hRbgLBoUWqm7pj
Ji3uVm3qFAjWQLBoeyVD0XfETU733CShAEWSP4pKsvfl7DNny/IBcGVM1j5g
+kf1BKP8QSPOGtR2dUZQIfjg0gUUuRaUU/JHItGUdua6XygcIf/g9RB+6pBx
SbSbMyKEjl+K+NhUcD6DavtrG4+sC4WTOdtqzxRZvnxQ09LlBLUWh4UMkjgd
L2j8C9z7dHgvL/ifR73plPSqL+RDiuLCthjjjGIj+DATbB5RlPQO+501AAyH
bwk1
=4CmY
- -----END PGP SIGNATURE-----

-----BEGIN PGP SIGNATURE-----
Version: Mailvelope v0.13.1
Comment: https://www.mailvelope.com

wsFcBAEBCAAQBQJVVMtXCRDmVDuy+mK58QAANCAP/i58Tb1zbtP6ZblgxTKV
N7cXLTNZAoVvSdMWj9VcP//2Ha9CMFV/Qu9GrVdeOJkDfcvn2T6Hx6UU0l6P
5cvRD6LDG+g8JFuh2kGZksarBBq47/Leg7Z57OQcQGh/59sIkmj7LiXzguZo
r9lB9F19j5Ejy91ztF2Ai+VHV7hEN+qRY/UQjCnL/PfyGzBgsL3emMg7NHde
stDyzRVIKDKbwELYPYaTn1vNYq7NAY9F5ziuDd5LDKdma61UtBloPmVtxaiN
WaycGVey3FlB0CeQKwqee0ZhkC2YhqhK0LjyTB3NhlLSHTEhiSjRIUMZeKX1
9H99HcYS6GjI9WBJ3MudznwPkkIwqzN4BKkgbcyYql/NNU0jzCHDNQ8lnbCa
+wCaKXQl4rLhrdQTRnFramVPuO6vPpUp85HsNA+xKrddFBBU+/RU6tK4OTgv
5XoYMVc8+aaZd1k62fjCafGs/B7a9QnYtU5GFOo67p7UnsZ2ISGKEv3fnR+E
eeXQ+2AKdjKB1f9XZcG6JLrY10ddwNmjz0dDNNxTo+Dd427hpspQaf1WRDyx
Lb1Qq4O+xx8bNbzPZHcSlNPq6tdCJKri7ZC8vCU3aXLXMKvTk5fRrA56qTkk
SsaOYqpYk9gbYj2bQeLjIY+lFrrsm1/NqzvXIHfX7BYbTiYKKl5ncDeDAjTq
sk6v
=cY5H
-----END PGP SIGNATURE-----

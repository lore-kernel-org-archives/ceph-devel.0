From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: CentOS 7 yum-builddep fails on %if
Date: Wed, 25 Mar 2015 12:37:44 -0600
Message-ID: <55130078.4040908@redhat.com>
References: <5512F699.3000206@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53736 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752620AbbCYShp (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 25 Mar 2015 14:37:45 -0400
In-Reply-To: <5512F699.3000206@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 03/25/2015 11:55 AM, Loic Dachary wrote:
> Hi Ken,
> 
> yum-builddep fails on CentOS 7 on the latest ceph.spec.in with the
> following error:
> 
> error: parse error in expression error:
> /tmp/install-deps.52/ceph.spec:50: bad %if condition Bad spec:
> /tmp/install-deps.52/ceph.spec
> 
> which is
> 
> %if 0%{_with_systemd}
> 
> https://github.com/ceph/ceph/blob/master/ceph.spec.in#L50
> 
> It looks good to me though. Any idea why it happens ?
> 
> Cheers
> 

As we discussed in #ceph-devel this afternoon, the problem was a
syntax error in my RPM conditionals. The fix is in
https://github.com/ceph/ceph/pull/4181

- - Ken
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVEwB0AAoJEEeKlH94IJasmJQP+wWNQZi3MykY73A2oso5fSEn
fDT7sciapbsspflIu8TETO77l2Xht8WuE9BV1W6Bi8Q9h1FottaYUJfLx3BLiLfG
maouHmpTh4NT4AKzLertMKp3RDbCIv/vF/EaANbDe6CDSO5i2LuB6IqhyR6O5g/L
4lyW4VgniFD98oxhwQv0s2f0SyIbvXJEbS7P0keUSSMW3rYutQwkINXkJAXSru44
EUql2UJcUf5AMZ4tVr01NlxDt85Qalgy/fDA5ojMTMva+wtIpKIWoQFDbusF8KWP
/85Nq9avTgr5D28lJmdXSW3cLe2P+9rcY3eRYDS0qFl7FgI+5WyVdQHKSex2hmwH
oajbLNBsXerROtbfp9Q/m7Zmsz2FianDFD+QZBQ3TPGOugWgIondDAa7WcOo2y5c
YNasvayJ5v/Ic3E+JtcZ72uQq0zyzu9CD0pfYZWuXuIsKOo1Olj4Lofyf3E3PGla
YDth8ZykLiE0eieh0toMxrOMxbhY9o0ulsekYLQxlJ2MOm6II/3/8jYb6KcU4iTU
9ywX2O0aWhR8Hl9nN+xghu4fPpVbI7NhslNcp54aAfvcPZ7EKDXOhT+K8zo6LFAF
6F5DEUeBsiQsdx2FAU/GKxkyigEBh0BR+WmWvNYejUce86O/P0L47wvsLU2iQszF
A+SIs8RcGH3jdUQ4L+8K
=Bwy3
-----END PGP SIGNATURE-----

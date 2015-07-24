From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: reconciliation between firefly and v0.80.8.2
Date: Fri, 24 Jul 2015 11:43:44 -0600
Message-ID: <55B27950.9070409@redhat.com>
References: <55B2708B.1020705@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41227 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752968AbbGXRnp (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 24 Jul 2015 13:43:45 -0400
In-Reply-To: <55B2708B.1020705@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 07/24/2015 11:06 AM, Loic Dachary wrote:
> * build: remove LIBPERFGLUE from LIBMDS 
>   is unique to v0.80.8.2 and it is unclear why it was found to be usefu in
>   isolation. An issue for firefly backport of
>   http://tracker.ceph.com/issues/10691 was open at
>   http://tracker.ceph.com/issues/12461#note-1

Yeah, to shed more light why we found that patch to be important downstream:

The RHEL product has strict requirements about support, stability, ABI
guarantees, etc. Our team's able to support the gperftools-libs package
for the Ceph product, but not for all of RHEL. Since
/usr/bin/ceph-dencoder was only thing in ceph-common that links again
libtcmalloc, if we could fix the over-linking there, then we avoid the
whole issue.

The downstream BZ that corresponds to that ceph.com Redmine ticket is
https://bugzilla.redhat.com/1186953 in case anyone's interested.

- Ken

From: "Matt W. Benjamin" <matt@cohortfs.com>
Subject: Re: Ceph authentication/authorization paradignms
Date: Thu, 28 Aug 2014 13:55:22 -0400 (EDT)
Message-ID: <1925059576.144.1409248522066.JavaMail.root@thunderbeast.private.linuxbox.com>
References: <1220650621.35093917.1408643819096.JavaMail.zimbra@redhat.com>
Reply-To: "Matt W. Benjamin" <matt@cohortfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aa.linuxbox.com ([69.128.83.226]:1559 "EHLO aa.linuxbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751127AbaH1Rz3 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 28 Aug 2014 13:55:29 -0400
In-Reply-To: <1220650621.35093917.1408643819096.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Christopher R. Hertel" <crh@redhat.com>
Cc: ceph-devel@vger.kernel.org

Hi Chris,

----- "Christopher R. Hertel" <crh@redhat.com> wrote:

> Matt:
> 
> Thanks for the pointers.  I'm currently knee-deep in traditional
> Kerberos authentication code and trying to crack the FreeIPA PAM
> API.
> 
> I'm a community-oriented developer.  Any deeper dive you can
> provide would be encouraging.  :)
> 
> Chris -)-----


The two efforts I am aware of are rxgk (OpenAFS) and RPCSEC_GSSv3 (NFSv4).

The older of the two efforts I believe is rxgk, and had dual goals of addressing the AFS "cache poisoning" problem, and secondarily introducing support for separately managed (file) servers.  I believe RPCSEC_GSSv3 was initially conceived (by Nico Williams) as a means of addressing the NFSv4 equivalent of the cache poisoning problem, but the current work on it (by Andy Adamson) is as a dependency of NFSv4.2 server-side copy.  (Apologies to the participants if I am mis-reporting any of the history.)

The IETF discussion of these efforts is on Kitten and NFSv4.  There's interesting recent discussion on the Kitten WG alias.

Pointers:

http://www.ietf.org/internet-drafts/draft-wilkinson-afs3-rxgk-afs-06.txt
https://datatracker.ietf.org/doc/draft-ietf-nfsv4-rpcsec-gssv3

-- 
Matt Benjamin
CohortFS, LLC.
206 South Fifth Ave. Suite 150
Ann Arbor, MI  48104

http://cohortfs.com

tel.  734-761-4689 
fax.  734-769-8938 
cel.  734-216-5309 

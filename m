From: Robert LeBlanc <robert@leblancnet.us>
Subject: Re: try-restart on upgrade, and upgrade procedures in general
Date: Wed, 9 Sep 2015 14:17:21 -0600
Message-ID: <CAANLjFrbOmpYwUERuADWAu+pt0qQ8Rpq0gMVWBkc+CTRT4C8yw@mail.gmail.com>
References: <55EFF135.4040706@suse.cz>
	<55EFF255.20001@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yk0-f169.google.com ([209.85.160.169]:36720 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753178AbbIIURW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Sep 2015 16:17:22 -0400
Received: by ykdt18 with SMTP id t18so13689714ykd.3
        for <ceph-devel@vger.kernel.org>; Wed, 09 Sep 2015 13:17:22 -0700 (PDT)
In-Reply-To: <55EFF255.20001@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Sounds reasonable to me.
- ----------------
Robert LeBlanc
PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1


On Wed, Sep 9, 2015 at 2:48 AM, Nathan Cutler  wrote:
> Hi all:
>
> I have been tinkering with the %preun and %postun scripts in
> ceph.spec.in - in particular, the ones for the "ceph" and "ceph-radosgw"
> packages.
>
> Recently, as part of the "wip-systemd" effort, these snippets were
> updated for compatibility with systemd. Since the "Upgrade procedures"
> documentation[1] is going to have to be updated anyway, I hope we might
> have a discussion on these upgrade procedures.
>
> Based on my research and discussions to-date, it seems like there are
> two camps:
>
> The first camp says "upgrade should not touch running daemons;
> restarting them should be left to the admin." This is closely related to
> the idea that daemons should be upgraded and restarted individually:
> i.e., mons first, then osds, etc.
>
> The second camp says: "since the typical workflow for upgrading a
> package in Linux distributions involves having the package itself
> automatically restart running daemons, the Ceph package should do
> this, too".
>
> The first camp's position appears to be motivated primarily by a desire
> to keep the cluster up and running during the upgrade, and minimize
> disruption by proceeding "daemon by daemon".
>
> The second camp's position is driven by distribution packaging
> conventions and the fact that all the Ceph daemons and systemd units
> (except RGW) are packaged together. This lends itself to a "node by
> node" approach to upgrading, rather than "daemon by daemon". (Also,
> since there is always a risk that an upgrade might cause an entire node
> to fail, Ceph clusters need to be able to cope with an entire node going
> offline for upgrade. This might even be an argument for *recommending*
> "node by node" as an upstream-sanctioned upgrade procedure!)
>
> It was suggested to me that a nice way to reconcile these two camps
> would be to introduce an /etc/sysconfig/ceph (/etc/default/ceph) option,
> which I have provisionally called CEPH_AUTO_RESTART_ON_UPGRADE. If this
> option is set to "yes", the packaging scriptlet that is run on upgrade
> would do a "systemctl try-restart" on all the systemd units in the
> respective package. If it were not set, or set to any value other than
> "yes", the current behavior would be preserved.
>
> Opinions? Ideas?
>
> So far, I have opened https://github.com/ceph/ceph/pull/5835 with the
> RPM implementation.
>
> [1] http://ceph.com/docs/master/install/upgrading-ceph/#upgrade-procedures
>
> --
> Nathan Cutler
> Software Engineer Distributed Storage
> SUSE LINUX, s.r.o.
> Tel.: +420 284 084 037
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-----BEGIN PGP SIGNATURE-----
Version: Mailvelope v1.0.2
Comment: https://www.mailvelope.com

wsFcBAEBCAAQBQJV8JPNCRDmVDuy+mK58QAApuQP/AmeeoURF47/+0m6m50M
EiXajepqOdTP7NWgOFISmT5HC0VfDuU+D2JgGqBeeaEn4uMG9ls/nonVLGTl
kfmWPN7geWPrY0yWyGTgRvgw6hK7DyrDKocFVmefAopP3OPNYKEBDAXgPjq/
3aP0/EcdMgi/sRMqfdsbo+akSL477FGJZqb2ppLSrxvGhYebXWimS0hSxs0I
bY6vuzq6LQRtrQ1hBlUPybRwQTJAWK8Lto17eGJc8WNa7gcd6uhPzCQ35vqR
JwPwJoflx+G1LVMeO74nMX3P7dA8GMuXgRn9i1FmmZU1CdNGg/wq7bp8Fqq5
B11m8YqaMKHX6p+KYDphYmAiOXpVPZAbkBqh9L5OOftdEfzuU1Jg8VNOM9Ae
0WpCLLJVXoxUTSazOWQvsPGRnLhbeimSmmuSsVPsg52BkzF0/DZ1ALlj8PvV
Vyr4um6e39AbKRhGagZmjwbb+749P6F32/ohY8AuTgSuGwkq7/J2OI+yNpzU
cY/cbhGCNNuBNkBG6MOatMjbH7almlSB53H1yP/j2CbmAd50n6cKyvK0ntvc
Igsx9NEb2jXP7J5PwJG2qfvxP+d46nEk207jOI6Lfq7DPpJDbyOU3808f5ST
aFJ5pucADGujKsE2YX5L0ALbdzid3fWMnrdutqMpwoUJN37P4MMqsAsBupHo
Q4rG
=7Nsa
-----END PGP SIGNATURE-----

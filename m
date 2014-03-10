From: Florian Haas <florian@hastexo.com>
Subject: Ceph Puppet modules (again)
Date: Mon, 10 Mar 2014 17:21:55 +0100
Message-ID: <CAPUexz9vuQ7Z91i8wwR1d9heuvkmTp9=q4GSRkNZaMV2M4Tz1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f177.google.com ([209.85.216.177]:60302 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752880AbaCJQWQ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Mar 2014 12:22:16 -0400
Received: by mail-qc0-f177.google.com with SMTP id w7so7817216qcr.8
        for <ceph-devel@vger.kernel.org>; Mon, 10 Mar 2014 09:22:15 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

Somehow I'm thinking I'm opening a can of worms, but here it goes
anyway. I saw some discussion about this here on this list last
(Northern Hemisphere) autumn, but not much since.

I'd like to ask for some clarification on the current state of the
Ceph Puppet modules. Currently there are several: one on StackForge
(http://git.openstack.org/cgit/stackforge/puppet-ceph/), primarily
written by Lo=C3=AFc Dachary, and one on the eNovance GitHub repo
(https://github.com/enovance/puppet-ceph), written by S=C3=A9bastien Ha=
n
and Fran=C3=A7ois Charlier. The eNovance repo is AGPL licensed, which I
find rather incomprehensible =E2=80=94 the only thing this would make s=
ense
for would be to force providers of *public* Puppet hosts to contribute
back upstream, but that's a really far fetched use case. The
StackForge repo is ASL licensed, which looks a bit saner.

Then there is a TelekomCloud fork of the eNovance repo at
https://github.com/TelekomCloud/puppet-ceph/tree/rc/eisbrecher, with
55 unmerged patches. Also AGPL, as far as I can tell.

And finally there's puppet-cephdeploy
(https://github.com/dontalton/puppet-cephdeploy) where I like that it
builds upon ceph-deploy, but rather dislike that it's rather closely
interwoven with OpenStack. ASL.

=46inally, after the discussion that Lo=C3=AFc kicked off in
https://www.mail-archive.com/ceph-devel@vger.kernel.org/msg16673.html,
there's https://github.com/ceph/puppet-ceph which hasn't seen any
updates in 2 months. This is a mirror of the StackForge module, as far
as I can tell, is ASL licensed and has seen neither the eNovance work
nor the TelekomCloud updates, presumably on account of the license
issue.

Neither repo seems to be universally accepted and fully complete
(StackForge only supports mon deployment; eNovance doesn't do radosgw,
for example), so I'm trying to understand where people should best
direct their efforts to get things to a working state.

All thoughts and comments appreciated. Thanks!

Cheers,
=46lorian
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

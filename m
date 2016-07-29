From: Sebastien Han <shan@redhat.com>
Subject: [Feature request] config diff on a single option with the admin socket
Date: Fri, 29 Jul 2016 12:12:30 +0200
Message-ID: <CA+HUO7+qxtsS03yKp2ETUhKy6WTX1ESd0Xridw13viWwa0Cj3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:38869 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751586AbcG2KMw convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Jul 2016 06:12:52 -0400
Received: by mail-wm0-f47.google.com with SMTP id o80so144848335wme.1
        for <ceph-devel@vger.kernel.org>; Fri, 29 Jul 2016 03:12:51 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

The basic idea would be to have the ability to request the default
value of a config option.
We currently have "config diff" that returns all the diff.
I'd like to have the same but for a specific option only.

So something like:

ceph daemon mon.ceph-mon-01 config diff get <field>

Which will return the diff between the actual config value and the
original config value.

I don't think it's hard to do since we already have the "config diff".
To give you a bit more context, this is needed by ceph-ansible while
applying new config options into the ceph.conf.

Thanks in advance!

--=20
Cheers

=E2=80=93=E2=80=93=E2=80=93=E2=80=93=E2=80=93=E2=80=93
S=C3=A9bastien Han
Principal Storage Architect

"Always give 100%. Unless you're giving blood."

Mail: seb@redhat.com
Address: 11 bis, rue Roqu=C3=A9pine - 75008 Paris
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

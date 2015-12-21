From: David Casier <david.casier@aevoo.fr>
Subject: Fwd: FileStore : no wait thread queue_sync
Date: Mon, 21 Dec 2015 23:22:13 +0100
Message-ID: <CA+gn+zkmp1tpfbASL5FNo3MgRPTNNZAE_E=XFa1M0dXOAKOUeA@mail.gmail.com>
References: <CA+gn+zk090MQ=NktqKLdHUXbrJbsfcDtape7DnLC0WOQuA5qbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37847 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750985AbbLUWWO convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Dec 2015 17:22:14 -0500
Received: by mail-wm0-f44.google.com with SMTP id p187so87888990wmp.0
        for <ceph-devel@vger.kernel.org>; Mon, 21 Dec 2015 14:22:13 -0800 (PST)
In-Reply-To: <CA+gn+zk090MQ=NktqKLdHUXbrJbsfcDtape7DnLC0WOQuA5qbg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

=46YI.
---------- Forwarded message ----------
=46rom: David Casier <david.casier@aevoo.fr>
Date: 2015-12-21 23:19 GMT+01:00
Subject: FileStore : no wait thread queue_sync
To: Ceph Development <ceph-devel@vger.kernel.org>, Sage Weil <sage@newd=
ream.net>
Cc: Beno=C3=AEt LORIOT <benoit.loriot@aevoo.fr>, S=C3=A9bastien VALSEME=
Y
<sebastien.valsemey@aevoo.fr>


Hi,
What do you think about :

if (!journal && m_filestore_direct) {
  apply_manager.commit_finish
}
 in FileStore::queue_transactions  ?
=46or direct and no waiting (sync_entry thread) ?

I would also propose putting a parameter "m_omap_is_safe" for bypass
XATTR_SPILL_OUT_NAME and reduce IOPS in hard_drive

if ( !m_omap_is_safe) {
    r =3D chain_fgetxattr(**o, XATTR_SPILL_OUT_NAME, buf, sizeof(buf));
    if (r >=3D 0 && !strncmp(buf, XATTR_NO_SPILL_OUT,
sizeof(XATTR_NO_SPILL_OUT))) {
      r =3D chain_fsetxattr(**n, XATTR_SPILL_OUT_NAME, XATTR_NO_SPILL_O=
UT,
                          sizeof(XATTR_NO_SPILL_OUT));
    } else {
      r =3D chain_fsetxattr(**n, XATTR_SPILL_OUT_NAME, XATTR_SPILL_OUT,
                          sizeof(XATTR_SPILL_OUT));
    }
}

--=20

________________________________________________________

Cordialement,

David CASIER

________________________________________________________



--=20

________________________________________________________

Cordialement,

David CASIER

________________________________________________________
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

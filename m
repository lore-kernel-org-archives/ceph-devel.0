From: John Spray <jspray@redhat.com>
Subject: Re: ceph-create-keys: mds "allow *" vs "mds allow"
Date: Thu, 16 Jun 2016 16:10:17 +0100
Message-ID: <CALe9h7d_xWZ0WAZNYfTXJaf9afpc7OHkruy5RV6=P5BD2Aq-+Q@mail.gmail.com>
References: <1866707938.418.1466087949783@webmail.proxmox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:33937 "EHLO
	mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754047AbcFPPKj convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Jun 2016 11:10:39 -0400
Received: by mail-oi0-f42.google.com with SMTP id d132so73838096oig.1
        for <ceph-devel@vger.kernel.org>; Thu, 16 Jun 2016 08:10:38 -0700 (PDT)
In-Reply-To: <1866707938.418.1466087949783@webmail.proxmox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?Q?Fabian_Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Dietmar Maurer <dietmar@proxmox.com>

On Thu, Jun 16, 2016 at 3:39 PM, Fabian Gr=C3=BCnbichler
<f.gruenbichler@proxmox.com> wrote:
> Hello,
>
> we already filed an issue over at Redmine (http://tracker.ceph.com/is=
sues/16255), but since this is more of a question than bug report, I wi=
ll repeat it here (and hope to get more insight ;))
>
> The ceph documentation for monitor bootstrapping (http://tracker.ceph=
=2Ecom/issues/16255) says to create the client.admin key with (among ot=
her things) "--cap mds 'allow'" (while the cap for mon and osd is set t=
o 'allow *', note the added ' *'). All our existing (users') ceph insta=
llations are setup with keyrings following this documentation, which wo=
rked find under Hammer.
>
> Recently (in Jewel?), ceph-create-keys was changed to call "ceph auth=
 get-or-create" with "mon 'allow *'" (again, note the added ' *'): http=
s://github.com/ceph/ceph/commit/c7e905e7e232a973abf7c6fa71a2ffbad7aa0ff=
d
>
> This is not only inconsistent with the current documentation, but als=
o breaks all the existing installations/keyrings, because get-or-create=
 will neither get nor create if the keyring exists, but the caps don't =
match.
>
> Any pointers on how to remedy this situation? I could not find any in=
formation in the release notes (e.g., for a potential upgrade path) and=
 either the change or the documentation seems to be wrong.

You can avoid this issue by leaving the admin key in place in
/etc/ceph on your mon nodes.  More detail in the ticket.

Cheers,
John

> Regards,
> Fabian
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

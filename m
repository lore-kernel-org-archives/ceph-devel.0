From: Alexandre Marangone <amarango@redhat.com>
Subject: Re: [RADOSGATEWAY] Admin API
Date: Tue, 8 Dec 2015 10:44:23 -0800
Message-ID: <CADjxd3LBOEZGXE_Z_WQ2xntYW5JZsAxjbz7VXgO1NbJgVcvmUQ@mail.gmail.com>
References: <28235_1449596706_56671722_28235_9397_1_B9C8EFBF13B1354DB5FA000660D66DD00D668DB9@OPEXCLILM22.corporate.adroot.infra.ftgroup>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f178.google.com ([209.85.223.178]:35755 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751892AbbLHSoY convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Dec 2015 13:44:24 -0500
Received: by ioc74 with SMTP id 74so33587057ioc.2
        for <ceph-devel@vger.kernel.org>; Tue, 08 Dec 2015 10:44:23 -0800 (PST)
In-Reply-To: <28235_1449596706_56671722_28235_9397_1_B9C8EFBF13B1354DB5FA000660D66DD00D668DB9@OPEXCLILM22.corporate.adroot.infra.ftgroup>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ghislain.chevalier@orange.com
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Ghislain,

These infos are available with the metadata API. You will need to add
the cap metadata=3Dread to your admin user.
The API call is: /admin/metadata/user?key=3D<user>

Best,

Alex

On Tue, Dec 8, 2015 at 9:45 AM,  <ghislain.chevalier@orange.com> wrote:
> Hi,
>
> Context : Firefly 0.80.10
>
> I use the rgw admin api to get information about user from
> http://docs.ceph.com/docs/master/radosgw/adminops/#get-user-info
>
> The get request doesn't return all the information that we can get wi=
th radosgw-admin user info --uid=3D<username>
> The metadata such as op_mask, system, default_placement, placement_ta=
gs, bucket_quota, user_quota, and temp_url_keys  are missing.
>
> Is the admin api going to evolve in order to get those information?
>
> Brgds
>
> - - - - - - - - - - - - - - - - -
> Ghislain Chevalier
> ORANGE/IMT/OLPS/ASE/DAPI/CSE
> Architecte de services d=E2=80=99infrastructure de stockage
> Sofware-Defined Storage Architect
>  +33299124432
>  +33788624370
> ghislain.chevalier@orange.com
> =EF=81=90 Pensez =C3=A0 l'Environnement avant d'imprimer ce message !
>
>
>
> _____________________________________________________________________=
____________________________________________________
>
> Ce message et ses pieces jointes peuvent contenir des informations co=
nfidentielles ou privilegiees et ne doivent donc
> pas etre diffuses, exploites ou copies sans autorisation. Si vous ave=
z recu ce message par erreur, veuillez le signaler
> a l'expediteur et le detruire ainsi que les pieces jointes. Les messa=
ges electroniques etant susceptibles d'alteration,
> France Telecom - Orange decline toute responsabilite si ce message a =
ete altere, deforme ou falsifie. Merci
>
> This message and its attachments may contain confidential or privileg=
ed information that may be protected by law;
> they should not be distributed, used or copied without authorization.
> If you have received this email in error, please notify the sender an=
d delete this message and its attachments.
> As emails may be altered, France Telecom - Orange shall not be liable=
 if this message was modified, changed or falsified.
> Thank you.
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

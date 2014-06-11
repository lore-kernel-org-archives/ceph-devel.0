From: Gregory Farnum <greg@inktank.com>
Subject: Re: [Ceph] Managing crushmap
Date: Wed, 11 Jun 2014 10:02:56 -0700
Message-ID: <CAPYLRzjj7C2HhHtwFqBJ6zPUeF-pPnhVMmceZSYOgSy-cPOzwA@mail.gmail.com>
References: <31473_1402478241_53981EA1_31473_30_1_B9C8EFBF13B1354DB5FA000660D66DD00C122930@PEXCVZYM14.corporate.adroot.infra.ftgroup>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171]:42531 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751220AbaFKRC5 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Jun 2014 13:02:57 -0400
Received: by mail-qc0-f171.google.com with SMTP id w7so51345qcr.2
        for <ceph-devel@vger.kernel.org>; Wed, 11 Jun 2014 10:02:56 -0700 (PDT)
In-Reply-To: <31473_1402478241_53981EA1_31473_30_1_B9C8EFBF13B1354DB5FA000660D66DD00C122930@PEXCVZYM14.corporate.adroot.infra.ftgroup>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ghislain.chevalier@orange.com
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

That doesn't sound right. Can you supply your decompiled CRUSH map,
the exact commands you ran against the ceph cluster, and the exact
version(s) you ran the test against?
-Greg

Software Engineer #42 @ http://inktank.com | http://ceph.com


On Wed, Jun 11, 2014 at 2:17 AM,  <ghislain.chevalier@orange.com> wrote=
:
> Hi all,
>
> Context :
> Lab Platform
> Ceph dumpling and firefly
> Ubuntu 12.04 LTS
>
> I encountered a strange behavior managing the crushmap on a dumpling =
and a firefly ceph platform.
>
> I built a crushmap, adding 2 specific rules (fastrule and slowrule) i=
n order to experiment tiering.
> I used "ceph osd get|setcrushmap" and crushtool to extract and ingest=
 the updated crushmap in the system.
> I have to precise that I respectively associated 50 and 51 as ruleset=
 numbers for the 2 new rules.
> The ingestion was good; I checked it by "ceph osd crush rule dump"
>
> I created 2 pools (fastpool and slowpool)
> As indicated in the doc, I tried to associate fastpool to ruleset 50 =
by "ceph osd pool set fastpool crush_ruleset 50"
> an error occurred : rule 50 doesn't exist
> As the rule_id of fastrule is 4, I did "ceph osd pool set fastpool cr=
ush_ruleset 4" and it works but it's not a correct behavior.
> If a ceph admin wants to manage the crushmap, he doesn't have to chec=
k the rule_id (that he cannot set) before updating the attribute crush_=
ruleset of pools.
> The way to manage the rules if the ruleset not the rule_id.
>
> I also tested that reingesting a crushmap (after for example changing=
 the sequence of the rules in the decompiled file) causes a global upda=
te of the rule_ids.
> I can't imagine the impacts on a platform.
>
> Did someone encounter this behavior?
> Did I misunderstand how to configure a crushmap?
>
> Best regards
>
>
>
>
>
> - - - - - - - - - - - - - - - - -
> Ghislain Chevalier
> ORANGE/OLNC/OLPS/ASE/DAPI/CSE
> Architecte de services de stockage
> Storage Service Architect
>  +33299124432
> ghislain.chevalier@orange.com
> =EF=81=90 Pensez =C3=A0 l'Environnement avant d'imprimer ce message !
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
> Orange decline toute responsabilite si ce message a ete altere, defor=
me ou falsifie. Merci.
>
> This message and its attachments may contain confidential or privileg=
ed information that may be protected by law;
> they should not be distributed, used or copied without authorisation.
> If you have received this email in error, please notify the sender an=
d delete this message and its attachments.
> As emails may be altered, Orange is not liable for messages that have=
 been modified, changed or falsified.
> Thank you.
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

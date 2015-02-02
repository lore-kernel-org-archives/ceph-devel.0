From: Alfredo Deza <adeza@redhat.com>
Subject: Re: radosgw-agent failed to parse
Date: Mon, 2 Feb 2015 10:58:48 -0500
Message-ID: <CANtztVyC40R1-os=cuqOnk+L7RdyxwQrPcTLHRXMftakxGyX-A@mail.gmail.com>
References: <31740_1422885416_54CF8227_31740_2351_1_B9C8EFBF13B1354DB5FA000660D66DD00C1F804F@PEXCVZYM14.corporate.adroot.infra.ftgroup>
	<CANtztVx9RZs1h-vqLUNMWhq+PrWcAigzh7qb0dpzUeFXf6+Fgw@mail.gmail.com>
	<3704_1422888787_54CF8F53_3704_2219_1_B9C8EFBF13B1354DB5FA000660D66DD00C1F80ED@PEXCVZYM14.corporate.adroot.infra.ftgroup>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yk0-f180.google.com ([209.85.160.180]:53900 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932192AbbBBP6u convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Feb 2015 10:58:50 -0500
Received: by mail-yk0-f180.google.com with SMTP id 131so22187652ykp.11
        for <ceph-devel@vger.kernel.org>; Mon, 02 Feb 2015 07:58:49 -0800 (PST)
In-Reply-To: <3704_1422888787_54CF8F53_3704_2219_1_B9C8EFBF13B1354DB5FA000660D66DD00C1F80ED@PEXCVZYM14.corporate.adroot.infra.ftgroup>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ghislain.chevalier@orange.com
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

That sounds suspicious because we haven't packaged a 1.2.1 release.

The latest on PyPI is 1.2, which is the same in the master branch.

Would you mind sending logs that show *how* the url is malformed (both
when it is OK and when it is not) ?

On Mon, Feb 2, 2015 at 9:53 AM,  <ghislain.chevalier@orange.com> wrote:
> HI,
>
> Thx for replying
>
> According to dpkg -l, it's 1.2.1.
>
> I noticed that the URL is malformed when launching using directly rad=
osgw-agent -c <syncfile>
> but well formed when launching using service radosgw-agent start <syn=
cfile>
>
> best regards
>
> -----Message d'origine-----
> De : alfredo.deza@inktank.com [mailto:alfredo.deza@inktank.com] De la=
 part de Alfredo Deza
> Envoy=C3=A9 : lundi 2 f=C3=A9vrier 2015 15:18
> =C3=80 : CHEVALIER Ghislain IMT/OLPS
> Cc : ceph-devel@vger.kernel.org
> Objet : Re: [Ceph-devel] radosgw-agent failed to parse
>
> What version of the agent are you using? And when it fails, how does =
the log output look?
>
> On Mon, Feb 2, 2015 at 8:56 AM,  <ghislain.chevalier@orange.com> wrot=
e:
>> Hi all,
>>
>> Context : Ubuntu 14.04 TLS firefly 0.80.8
>>
>> I sent this post in ceph-users (identical subject) because I recentl=
y encountered the same issue.
>> Maybe I missed something between July and January...
>>
>> I found that the http request wasn't correctly formed by
>> /usr/lib/python2.7/dist-packages/radosgw_agent/client.py
>>
>> I did the changes below
>> #    url =3D '{protocol}://{host}{path}'.format(protocol=3Drequest.p=
rotocol,
>> #                                             host=3Drequest.host,
>> #                                             path=3Drequest.path)
>>      url =3D '{path}'.format(protocol=3D"", host=3D"", path=3Dreques=
t.path)
>>
>> The request is then correctly formed and sent.
>>
>> I still have problems setting the federation between 2 zones of 2 ce=
ph clusters in 2 regions.
>>
>> I go on investigating.
>>
>> Best regards
>>
>>
>> ____________________________________________________________________=
__
>> ___________________________________________________
>>
>> Ce message et ses pieces jointes peuvent contenir des informations
>> confidentielles ou privilegiees et ne doivent donc pas etre diffuses=
,
>> exploites ou copies sans autorisation. Si vous avez recu ce message
>> par erreur, veuillez le signaler a l'expediteur et le detruire ainsi=
 que les pieces jointes. Les messages electroniques etant susceptibles =
d'alteration, Orange decline toute responsabilite si ce message a ete a=
ltere, deforme ou falsifie. Merci.
>>
>> This message and its attachments may contain confidential or
>> privileged information that may be protected by law; they should not=
 be distributed, used or copied without authorisation.
>> If you have received this email in error, please notify the sender a=
nd delete this message and its attachments.
>> As emails may be altered, Orange is not liable for messages that hav=
e been modified, changed or falsified.
>> Thank you.
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
"
>> in the body of a message to majordomo@vger.kernel.org More majordomo
>> info at  http://vger.kernel.org/majordomo-info.html
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

From: Xiaoxi Chen <superdebuger@gmail.com>
Subject: Re: ceph v10.2.3 QE validation status
Date: Fri, 9 Sep 2016 20:41:22 +0800
Message-ID: <CAEYCsVK8gSeozJPu-eN-GnkW3Cd5P3uJrOYwA5VD9YqTCzUH3Q@mail.gmail.com>
References: <CAMMFjmHb=m_WJg8TMaVBOdXB37=viYOBSOYEXL_Bo3kET=hyoA@mail.gmail.com>
 <CAMMFjmFBW+Zdnx8Ux9mtKvh3W187oHL3UDqNpKtkHZ15Q=porg@mail.gmail.com> <57CFB4D4.1060706@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f171.google.com ([209.85.161.171]:36228 "EHLO
        mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753033AbcIIMlY (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Sep 2016 08:41:24 -0400
Received: by mail-yw0-f171.google.com with SMTP id u124so32913775ywg.3
        for <ceph-devel@vger.kernel.org>; Fri, 09 Sep 2016 05:41:23 -0700 (PDT)
In-Reply-To: <57CFB4D4.1060706@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Yuri Weinstein <yweinste@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Abhishek Varshney <abhishek.varshney@flipkart.com>, "Dachary, Loic" <ldachary@redhat.com>, "Weil, Sage" <sage@redhat.com>, "Just, Samuel" <sjust@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, David Zafman <dzafman@redhat.com>

Hi,
  Sorry for jump in , we just hit a bug
(http://tracker.ceph.com/issues/17252) in our production ,which blocks
cinder service ,  once cinder hit this bug th cinder-volume service
cannot serve anymore request.  It is not hard to reproduce---  our 6
cinder-volume nodes hitting this with 12 hours after restart.

  Discussed with Haomai, he will provide a PR very shortly. Do we have
any chance to get this in for 10.2.3 ? Suspecting everyone in jewel
will suffer from this bug.

Xiaoxi

2016-09-07 14:33 GMT+08:00 Loic Dachary <loic@dachary.org>:
> Hi Yuri,
>
> The deph-disk suite must be run on VPS.
>
> Cheers
>
> On 06/09/2016 22:26, Yuri Weinstein wrote:
>> Missed a line with ceph-disk issue -
>>
>> ceph-disk:
>>    http://tracker.ceph.com/issues/15350
>>    (Loic, Sam pls review/approve)
>>
>> On Tue, Sep 6, 2016 at 10:12 AM, Yuri Weinstein <yweinste@redhat.com> wr=
ote:
>>> Detailed summary of the QE Validation can be found here
>>> http://tracker.ceph.com/issues/16344#note-46
>>>
>>> The following suites were in scope of this point release validation:
>>>
>>> rados (subset 35/50 297 jobs)
>>> rbd
>>> rgw
>>> fs
>>> krbd
>>> kcephfs
>>> knfs
>>> rest
>>> hadoop
>>> samba
>>> ceph-deploy
>>> ceph-disk
>>> upgrade/client-upgrade
>>> upgrade/hammer-x (jewel)
>>> upgrade/infernalis-x (jewel)
>>> powercycle
>>> (please let me know if any suites are missing from this ^ list)
>>>
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>>> Issues requiring approval/decision:
>>>
>>> rados:
>>>    http://tracker.ceph.com/issues/16516 (approved by DavidZ)
>>>
>>> rbd:
>>>    multiple issues (Jason pls rview/approve, see notes
>>> http://tracker.ceph.com/issues/16344#note-46)
>>>
>>> krbd:
>>>    http://tracker.ceph.com/issues/17223
>>>    http://tracker.ceph.com/issues/17221
>>>    http://tracker.ceph.com/issues/17222
>>>    (Jason pls rview/approve)
>>>
>>> knfs
>>>    http://tracker.ceph.com/issues/17192
>>>    (Greg pls rview/approve, note: it's similar we saw in hammer point r=
elease)
>>>
>>> samba:
>>>    http://tracker.ceph.com/issues/17184
>>>    (Greg pls rview/approve)
>>>
>>> upgrade/client-upgrade:about:startpage
>>>    http://tracker.ceph.com/issues/16506
>>>    (Sage, Sam, Jason pls rview/approve)
>>>
>>> upgrade/infernalis-x (jewel):
>>>    http://tracker.ceph.com/issues/17176
>>>    (Sam, David  pls rview/approve)
>>>
>>> powercycle:
>>>    http://tracker.ceph.com/issues/17177
>>>    (Sage  pls rview/approve)
>>>
>>> Loic, given that we have high number of issues in this release, if you
>>> and dev leads find that we need to add more backports we may consider
>>> validating a new point RC (sha1).
>>>
>>> Thx
>>> YuriW
>>
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

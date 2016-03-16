From: Martin Palma <martin@palma.bz>
Subject: Re: GPG signing RPM packages : must not have subkeys
Date: Wed, 16 Mar 2016 09:10:22 +0100
Message-ID: <CANMxC7ASRu9APykMofY-MGMz5YOiVxGupc7y=EdY+0emhdnHXQ@mail.gmail.com>
References: <56E84635.8080109@dachary.org> <CANMxC7BPoRnHRGYXNNu2QmtcbrVP9HTiu3gtim5=aWW42HoAgw@mail.gmail.com>
 <56E91189.7070306@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:38103 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965971AbcCPIKn convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Mar 2016 04:10:43 -0400
Received: by mail-wm0-f53.google.com with SMTP id l68so60061326wml.1
        for <ceph-devel@vger.kernel.org>; Wed, 16 Mar 2016 01:10:42 -0700 (PDT)
In-Reply-To: <56E91189.7070306@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Perfekt!! :-)

On Wed, Mar 16, 2016 at 8:55 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi Martin,
>
> It works indeed ! Thanks :-)
>
> Cheers
>
> On 15/03/2016 20:25, Martin Palma wrote:
>> If I remember it right I read somewhere that verification with
>> sub-keys is not implemented in rpm.
>>
>> To create a passwordless key with no subkey you can simple leave out
>> the Subkey-Type and Subkey-Length I think:
>>
>>
>> KEY=3D"$HOME/.ceph-workbench/release-team-key.asc"
>> if ! test -f $KEY ; then
>>   printf "Key-Type: 1\nKey-Length: 2048\nName-Real: Release
>> Team\nName-Email: contact@ceph.com\nExpire-Date: 0" |
>> GNUPGHOME=3D~/.ceph-workbench gpg --batch --gen-key
>>   GNUPGHOME=3D~/.ceph-workbench gpg --export --armor > $KEY
>> fi
>>
>> Can you verify that?
>>
>> Best,
>> Martin
>>
>> On Tue, Mar 15, 2016 at 6:28 PM, Loic Dachary <loic@dachary.org> wro=
te:
>>> Hi Martin,
>>>
>>> It turns out that the key created by
>>>
>>> KEY=3D"$HOME/.ceph-workbench/release-team-key.asc"
>>> if ! test -f $KEY ; then
>>>   printf "Key-Type: 1\nKey-Length: 2048\nSubkey-Type: 1\nSubkey-Len=
gth: 2048\nName-Real: Release Team\nName-Email: contact@ceph.com\nExpir=
e-Date: 0" | GNUPGHOME=3D~/.ceph-workbench gpg --batch --gen-key
>>>   GNUPGHOME=3D~/.ceph-workbench gpg --export --armor > $KEY
>>> fi
>>>
>>> cannot be used to verify RPM packages: rpm -K on the signed package=
 claims the 69C8876E key is missing. It turns out to be related to the =
subkey.
>>>
>>> --------------------------------------------
>>> pub   2048R/B8F1ACED 2016-03-11
>>>       Key fingerprint =3D 7FEB E845 6F19 153B AAFC  2810 4597 2ACD =
B8F1 ACED
>>> uid                  A Contributor <generous@ceph.com>
>>> sub   2048R/69C8876E 2016-03-11
>>>
>>> rpm -K complains that the 69C8876E key is not available. After remo=
ving the subkey 69C8876E with gpg --edit-key and signing the RPM again,=
 rpm -K is happy. This does not make any sense to me and I suspect ther=
e is an expert explanation that justify this behavior. The sensible way=
 out seems to create a passwordless key with no subkey to avoid that pr=
oblem. Do you happen to know how that can be done ?
>>>
>>> Cheers
>>>
>>> --
>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

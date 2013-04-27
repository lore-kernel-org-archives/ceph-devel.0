From: Loic Dachary <loic@dachary.org>
Subject: Re: PG statechart
Date: Sat, 27 Apr 2013 11:16:22 +0200
Message-ID: <517B9766.3060409@dachary.org>
References: <517A9B3A.3080806@dachary.org> <281AE624-F6F6-4376-8130-77608D174646@inktank.com> <517B523D.8000503@dachary.org> <D58A1729-FB75-4F68-9E14-E1E3F4532336@inktank.com> <CA+4uBUbAuXPRyG_EuH12yXkLSu6_my1HzqcUmXvKCRkA50vWFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE0311D89DC03A5C192C0BA6D"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:54252 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754356Ab3D0JQ0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 27 Apr 2013 05:16:26 -0400
In-Reply-To: <CA+4uBUbAuXPRyG_EuH12yXkLSu6_my1HzqcUmXvKCRkA50vWFA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE0311D89DC03A5C192C0BA6D
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Sam,

I missed this one, thanks for the link :-) It is also a little easier bec=
ause
http://rtime.felk.cvut.cz/statechart-viewer/
complains about missing react for NullEvt and requires the following hack=
 to work

diff --git a/src/osd/PG.h b/src/osd/PG.h
index 578afd3..f6446a9 100644
--- a/src/osd/PG.h
+++ b/src/osd/PG.h
@@ -1332,6 +1332,7 @@ public:
       boost::statechart::result react(const Load&);
       boost::statechart::result react(const MNotifyRec&);
       boost::statechart::result react(const MInfoRec&);
+      boost::statechart::result react(const NullEvt&);
       boost::statechart::result react(const MLogRec&);
       boost::statechart::result react(const boost::statechart::event_bas=
e&) {
        return discard_event();
@@ -1353,6 +1354,7 @@ public:
       boost::statechart::result react(const QueryState& q);
       boost::statechart::result react(const AdvMap&);
       boost::statechart::result react(const ActMap&);
+      boost::statechart::result react(const NullEvt&);
       boost::statechart::result react(const FlushedEvt&);
       boost::statechart::result react(const boost::statechart::event_bas=
e&) {
        return discard_event();
@@ -1374,6 +1376,7 @@ public:
        > reactions;
       boost::statechart::result react(const QueryState& q);
       boost::statechart::result react(const AdvMap&);
+      boost::statechart::result react(const NullEvt&);
       boost::statechart::result react(const FlushedEvt&);
       boost::statechart::result react(const boost::statechart::event_bas=
e&) {
        return discard_event();


Cheers

On 04/27/2013 10:08 AM, Samuel Just wrote:
> There is actually a peering state diagram generated with the docs:
> http://ceph.com/docs/master/dev/peering/
>=20
> Unfortunately, the image comes out rather small, you can generate it
> for yourself with the script at doc/scripts/gen_state_diagram.py.
>>From admin/build_doc:
>=20
> cat src/osd/PG.h src/osd/PG.cc | doc/scripts/gen_state_diagram.py >
> doc/dev/peering_graph.generated.dot
>=20
> It's similar to the boost generated one, but also includes most of the
> state transitions from within the custom_reaction state chart
> reactions.
> -Sam
>=20
> On Fri, Apr 26, 2013 at 9:49 PM, Noah Watkins <noah.watkins@inktank.com=
> wrote:
>> Very cool!
>>
>> On Apr 26, 2013, at 9:21 PM, Loic Dachary <loic@dachary.org> wrote:
>>
>>> Hi Noah,
>>>
>>> Nice tool :-) Here is the statechart generated from PG.h.
>>>
>>> Cheers
>>>
>>> On 04/26/2013 06:07 PM, Noah Watkins wrote:
>>>> Boost Statechart Viewer generates GraphViz:
>>>>
>>>>  http://rtime.felk.cvut.cz/statechart-viewer/
>>>>
>>>> Having trouble with my LLVM environment on 12.04, so I haven't teste=
d it.
>>>>
>>>> -Noah
>>>>
>>>> On Apr 26, 2013, at 8:20 AM, Loic Dachary <loic@dachary.org> wrote:
>>>>
>>>>> Hi,
>>>>>
>>>>> I was considering drawing a statechart ( http://www.math-cs.gordon.=
edu/courses/cs211/ATMExample/SessionStatechart.gif ) to better understand=
 the transitions of PG
>>>>>
>>>>> https://github.com/ceph/ceph/blob/master/src/osd/PG.h#L1341
>>>>>
>>>>> and realized that it probably already exists somewhere. Does it ?
>>>>>
>>>>> /me hopefull ;-)
>>>>>
>>>>> --
>>>>> Lo=C4=8Fc Dachary, Artisan Logiciel Libre
>>>>>
>>>>
>>>
>>> --
>>> Lo=C4=8Fc Dachary, Artisan Logiciel Libre
>>> <PG.pdf>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--------------enigE0311D89DC03A5C192C0BA6D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlF7l2YACgkQ8dLMyEl6F20A3wCeJdWQOeaUfD+/Rzk5ndKOWwV4
LsIAnj06IhIH7Zys9S44/mMsVmvYDYix
=53vu
-----END PGP SIGNATURE-----

--------------enigE0311D89DC03A5C192C0BA6D--

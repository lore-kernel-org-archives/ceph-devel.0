From: Loic Dachary <loic@dachary.org>
Subject: Re: dumpling integration : valgrind leak
Date: Fri, 30 Jan 2015 18:56:28 +0100
Message-ID: <54CBC5CC.5050706@dachary.org>
References: <54CB9C78.5070504@dachary.org> <CA+4uBUZR3Dvy5gszM2pOVuLsjDGAKdhRo8YLnzaWg-HOEWgcbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="pJaQwq1NupUFwqnraCTlm5jBxK5knC22S"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:49930 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753970AbbA3R4b (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 30 Jan 2015 12:56:31 -0500
In-Reply-To: <CA+4uBUZR3Dvy5gszM2pOVuLsjDGAKdhRo8YLnzaWg-HOEWgcbw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sjust@redhat.com
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pJaQwq1NupUFwqnraCTlm5jBxK5knC22S
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

After a little digging I found https://github.com/ceph/ceph/commit/02fae9=
fc54c10b5a932102bac43f32199d4cb612 which seems to be a plausible fix in d=
umpling also https://github.com/ceph/ceph/pull/3552. What do you think ?

On 30/01/2015 16:35, Samuel Just wrote:
> Yeah, that's probably new.
> -Sam
>=20
> On Fri, Jan 30, 2015 at 7:00 AM, Loic Dachary <loic@dachary.org> wrote:=

>> Hi Sam,
>>
>> I stumbled upon what seems to be a leak at http://pulpito.ceph.com/loi=
c-2015-01-29_15:41:06-rados-dumpling-backports---basic-multi/730305/ and =
the valgrind xml file is at http://tracker.ceph.com/attachments/download/=
1610/v.txt
>>
>>     <text>612 (584 direct, 28 indirect) bytes in 1 blocks are definite=
ly lost in loss record 268 of 287</text>
>>       <fn>operator new(unsigned long)</fn>
>>       <fn>ReplicatedPG::get_object_context(hobject_t const&amp;, bool)=
</fn>
>>       <line>4585</line>
>>       <fn>ReplicatedPG::find_object_context(hobject_t const&amp;, Obje=
ctContext**, bool, snapid_t*)</fn>
>>       <line>4658</line>
>>       <fn>ReplicatedPG::do_op(std::tr1::shared_ptr&lt;OpRequest&gt;)</=
fn>
>>       <line>835</line>
>>       <fn>PG::do_request(std::tr1::shared_ptr&lt;OpRequest&gt;, Thread=
Pool::TPHandle&amp;)</fn>
>>       <line>1455</line>
>>       <fn>OSD::dequeue_op(boost::intrusive_ptr&lt;PG&gt;, std::tr1::sh=
ared_ptr&lt;OpRequest&gt;, ThreadPool::TPHandle&amp;)</fn>
>>       <line>7169</line>
>>       <fn>OSD::OpWQ::_process(boost::intrusive_ptr&lt;PG&gt;, ThreadPo=
ol::TPHandle&amp;)</fn>
>>       <line>7141</line>
>>       <fn>ThreadPool::WorkQueueVal&lt;std::pair&lt;boost::intrusive_pt=
r&lt;PG&gt;, std::tr1::shared_ptr&lt;OpRequest&gt; &gt;, boost::intrusive=
_ptr&lt;PG&gt; &gt;::_void_process(void*, ThreadPool::TPHandle&amp;)</fn>=

>>       <line>191</line>
>>       <fn>ThreadPool::worker(ThreadPool::WorkThread*)</fn>
>>       <line>128</line>
>>       <fn>ThreadPool::WorkThread::entry()</fn>
>>       <line>318</line>
>>       <fn>start_thread</fn>
>>       <line>312</line>
>>       <fn>clone</fn>
>>       <line>111</line>
>>
>> A quick grep of get_object_context in redmine does not hit. Does it ri=
ng a bell ?
>>
>> Cheers
>>
>> dumpling backport inventory: http://tracker.ceph.com/issues/10560
>> ticket: http://tracker.ceph.com/issues/10697
>>
>> --
>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--pJaQwq1NupUFwqnraCTlm5jBxK5knC22S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTLxcwACgkQ8dLMyEl6F23ZXACdFxNPi9VHVNvZzo55zXp3oh9M
soUAoKid/WXmlGSGA4sV/QGANfr4I3an
=HK+W
-----END PGP SIGNATURE-----

--pJaQwq1NupUFwqnraCTlm5jBxK5knC22S--

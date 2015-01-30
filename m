From: Loic Dachary <loic@dachary.org>
Subject: dumpling integration : valgrind leak
Date: Fri, 30 Jan 2015 16:00:08 +0100
Message-ID: <54CB9C78.5070504@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="hAFcwKNO0GBcmq1PVnnRJk1BDp1q116LS"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:49817 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759645AbbA3PAL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 30 Jan 2015 10:00:11 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hAFcwKNO0GBcmq1PVnnRJk1BDp1q116LS
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Sam,

I stumbled upon what seems to be a leak at http://pulpito.ceph.com/loic-2=
015-01-29_15:41:06-rados-dumpling-backports---basic-multi/730305/ and the=
 valgrind xml file is at http://tracker.ceph.com/attachments/download/161=
0/v.txt=20

    <text>612 (584 direct, 28 indirect) bytes in 1 blocks are definitely =
lost in loss record 268 of 287</text>
      <fn>operator new(unsigned long)</fn>
      <fn>ReplicatedPG::get_object_context(hobject_t const&amp;, bool)</f=
n>
      <line>4585</line>
      <fn>ReplicatedPG::find_object_context(hobject_t const&amp;, ObjectC=
ontext**, bool, snapid_t*)</fn>
      <line>4658</line>
      <fn>ReplicatedPG::do_op(std::tr1::shared_ptr&lt;OpRequest&gt;)</fn>=

      <line>835</line>
      <fn>PG::do_request(std::tr1::shared_ptr&lt;OpRequest&gt;, ThreadPoo=
l::TPHandle&amp;)</fn>
      <line>1455</line>
      <fn>OSD::dequeue_op(boost::intrusive_ptr&lt;PG&gt;, std::tr1::share=
d_ptr&lt;OpRequest&gt;, ThreadPool::TPHandle&amp;)</fn>
      <line>7169</line>
      <fn>OSD::OpWQ::_process(boost::intrusive_ptr&lt;PG&gt;, ThreadPool:=
:TPHandle&amp;)</fn>
      <line>7141</line>
      <fn>ThreadPool::WorkQueueVal&lt;std::pair&lt;boost::intrusive_ptr&l=
t;PG&gt;, std::tr1::shared_ptr&lt;OpRequest&gt; &gt;, boost::intrusive_pt=
r&lt;PG&gt; &gt;::_void_process(void*, ThreadPool::TPHandle&amp;)</fn>
      <line>191</line>
      <fn>ThreadPool::worker(ThreadPool::WorkThread*)</fn>
      <line>128</line>
      <fn>ThreadPool::WorkThread::entry()</fn>
      <line>318</line>
      <fn>start_thread</fn>
      <line>312</line>
      <fn>clone</fn>
      <line>111</line>

A quick grep of get_object_context in redmine does not hit. Does it ring =
a bell ?

Cheers

dumpling backport inventory: http://tracker.ceph.com/issues/10560
ticket: http://tracker.ceph.com/issues/10697

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--hAFcwKNO0GBcmq1PVnnRJk1BDp1q116LS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTLnHkACgkQ8dLMyEl6F217AQCfaQnYEeqtOkUJyxWGEC9oBJLc
08sAn26D7g1WgG6+Vv8wgwyZgYKCXHEX
=qrs+
-----END PGP SIGNATURE-----

--hAFcwKNO0GBcmq1PVnnRJk1BDp1q116LS--

From: Loic Dachary <loic@dachary.org>
Subject: PGLog.{cc,h} review request
Date: Sun, 19 May 2013 09:33:44 +0100
Message-ID: <51988E68.6080302@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC15EC5A34AE11B5068475BAF"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:59950 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753940Ab3ESIdr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 19 May 2013 04:33:47 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC15EC5A34AE11B5068475BAF
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Sam,

I would be grateful if you could review https://github.com/dachary/ceph/c=
ommit/eeb8854a41409ef4224bf42101a19de70916573c ( compiles ok + make check=
 runs but did not go thru teuthology or any manual tests ). It is a large=
 patch but I expect the followups to be smaller. I did not send a pull re=
quest because it is a first attempt and you may want me to rethink what w=
as done. It moves about 1000 lines out of the PG.{cc,h} ( i.e. 10% ). One=
 of the benefits is that reading PGLog.h gives a synthetic view of what s=
ervices the future PGLog API should provide.=20

Cheers

    move log, ondisklog, missing from PG to PGLog
   =20
    PG::log, PG::ondisklog, PG::missing are moved from PG to a new PGLog
    class and are made protected data members. It is a preliminary step
    before writing unit tests to cover the methods that have side effects=

    on these data members and define a clean PGLog API. It improves
    encapsulation and does not change any of the logic already in
    place.
   =20
    Possible issues :
   =20
    * an additional reference (PG->PGLog->IndexedLog instead of
      PG->IndexedLog for instance) is introduced : is it optimized ?
   =20
    * pg_log_t::splice converts its const_iterator into an iterator using=

      std::advance which goes thru each element of the logs up to the
      position of the const_iterator. If the log is long and the call is
      too frequent, there will be a noticeable performance penalty. Is it=

      called frequently enough to be a problem ?
   =20
    * rewriting log.log into pg_log.get_log().log affects the readability=

      but should be optimized and have no impact on performances
   =20
    The guidelines followed for this patch are:
   =20
    * const access to the data members are preserved, no attempt is made
      to define accessors
   =20
    * all non const methods are in PGLog, no access to non const methods =
of
      PGLog::log, PGLog::logondisk and PGLog::missing are provided
   =20
    * when methods are moved from PG to PGLog the change to their
      implementation is restricted to the minimum.
   =20
    * the PG::OndiskLog and PG::IndexedLog sub classes are moved
      to PGLog sub classes unmodified and remain public
   =20
    A const version of the pg_log_t::find_entry method was added.
   =20
    A const accessor is provided for PGLog::get_log, PGLog::get_missing,
    PGLog::get_ondisklog but no non-const accessor.
   =20
    Arguments are added to most of the methods moved from PG to PGLog so
    that they can get access to PG data members such as info or log_oid.
    A bound method pointer to PG::remove_snap_mapped_object is provided t=
o
    the merge_log, rewind_divergent_log and merge_old_entry. These additi=
ons
    are not repeated in the method notes below.
   =20
    The PGLog method are sorted according to the data member they modify.=

   =20
    //////////////////// missing ////////////////////
   =20
    * The pg_missing_t::{got,have,need,add,rm} methods are wrapped as
      PGLog::missing_{got,have,need,add,rm}
   =20
    //////////////////// log ////////////////////
   =20
    * PGLog::get_tail, PGLog::get_head getters are created
   =20
    * PGLog::set_tail, PGLog::set_head, PGLog::set_last_requested setters=
 are created
   =20
    * PGLog::index, PGLog::unindex, PGLog::add wrappers, PGLog::reset_rec=
overy_pointers are created
   =20
    * PGLog::splice is a wrapper for pg_log_t::splice that converts its
      const_iterator into an iterator
   =20
    * PGLog::clear_info_log replaces PG::clear_info_log
   =20
    * PGLog::trim replaces PG::trim
   =20
    //////////////////// log & missing ////////////////////
   =20
    * PGLog::claim_log is created with code extracted from
      PG::RecoveryState::Stray::react.
   =20
    * PGLog::split_into is created with code extracted from
      PG::split_into.
   =20
    * PGLog::recover_got is created with code extracted from
      ReplicatedPG::recover_got.
   =20
    * PGLog::activate_not_complete is created with code extracted
      from PG::active
   =20
    * PGLog:proc_replica_log is created with code extracted from
      PG::proc_replica_log
   =20
    * PGLog:write_log is created with code extracted from
      PG::write_log
   =20
    * PGLog::merge_old_entry replaces PG::merge_old_entry
   =20
    * PGLog::rewind_divergent_log replaces PG::rewind_divergent_log
   =20
    * PGLog::merge_log replaces PG::merge_log
   =20
    * PGLog:write_log is created with code extracted from PG::write_log. =
A
      non-static version is created for convenience but is a simple
      wrapper.
   =20
    * PGLog:read_log replaces PG::read_log. A non-static version is
      created for convenience but is a simple wrapper.
   =20
    * PGLog:read_log_old replaces PG::read_log_old.
  =20


--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enigC15EC5A34AE11B5068475BAF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlGYjmkACgkQ8dLMyEl6F22YBACgsyuRyVlQAdHNj4BjofEozpBj
G70AoIcxjYLLk4lhS6DP8L23q9+SCvYF
=hx/M
-----END PGP SIGNATURE-----

--------------enigC15EC5A34AE11B5068475BAF--

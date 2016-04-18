From: Dong Wu <archer.wudong@gmail.com>
Subject: osd start fail because encouter assert(oi.version == i->first) when read_log
Date: Mon, 18 Apr 2016 20:18:02 +0800
Message-ID: <CAAL-TMfnKPE0Fe2yxJ04t_m3EJUdFi4+oQ4C13XM58SK3xpO-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f49.google.com ([209.85.213.49]:36052 "EHLO
	mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342AbcDRMSI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Apr 2016 08:18:08 -0400
Received: by mail-vk0-f49.google.com with SMTP id c4so217427316vkb.3
        for <ceph-devel@vger.kernel.org>; Mon, 18 Apr 2016 05:18:02 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,
My osd restart fail and here is dump messeage.

    -5> 2016-04-18 09:39:13.709885 7f608462d840 15
filestore(/var/lib/ceph/osd/ceph-7) getattr
3.1a1_head/eef429a1/rb.0.130ee9.6b8b4567.0000000019b7/head//3 '_'
    -4> 2016-04-18 09:39:13.709928 7f608462d840 10
filestore(/var/lib/ceph/osd/ceph-7) getattr
3.1a1_head/eef429a1/rb.0.130ee9.6b8b4567.0000000019b7/head//3 '_' =
252
    -3> 2016-04-18 09:39:13.709937 7f608462d840 15 read_log  missing
83830'1639861 (83830'1639860) modify
eef429a1/rb.0.130ee9.6b8b4567.0000000019b7/head//3 by
client.1491380.0:90267 2016-04-17 07:32:28.7
    -2> 2016-04-18 09:39:13.709949 7f608462d840 15
filestore(/var/lib/ceph/osd/ceph-7) getattr
3.1a1_head/8835b1a1/rbd_header.3e01a6d9f226c/head//3 '_'
    -1> 2016-04-18 09:39:13.709993 7f608462d840 10
filestore(/var/lib/ceph/osd/ceph-7) getattr
3.1a1_head/8835b1a1/rbd_header.3e01a6d9f226c/head//3 '_' = 593
     0> 2016-04-18 09:39:13.712530 7f608462d840 -1 osd/PGLog.cc: In
function 'static void PGLog::read_log(ObjectStore*, coll_t, coll_t,
ghobject_t, const pg_info_t&, std::map<eversion_t, hobject_t>&, PGLog:
osd/PGLog.cc: 979: FAILED assert(oi.version == i->first)

 ceph version 0.94.6-3-g6d41ecd (6d41ecd419e034002e5b46c541d663308c16e5e9)
 1: (ceph::__ceph_assert_fail(char const*, char const*, int, char
const*)+0x72) [0xcec4f2]
 2: (PGLog::read_log(ObjectStore*, coll_t, coll_t, ghobject_t,
pg_info_t const&, std::map<eversion_t, hobject_t,
std::less<eversion_t>, std::allocator<std::pair<eversion_t const,
hobject_t> > >&, PGLog::Ind
 3: (PGLog::read_log(ObjectStore*, coll_t, coll_t, ghobject_t,
pg_info_t const&, std::basic_ostringstream<char,
std::char_traits<char>, std::allocator<char> >&)+0xdf) [0x93ba6f]
 4: (PG::read_state(ObjectStore*, ceph::buffer::list&)+0x127) [0x923987]
 5: (OSD::load_pgs()+0x8bb) [0x7f733b]
 6: (OSD::init()+0xdac) [0x7fbb2c]
 7: (main()+0x253e) [0x79e12e]
 8: (__libc_start_main()+0xf5) [0x7f6081c6e995]
 9: /usr/bin/ceph-osd() [0x7a41d7]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.

from the core message, i checked PGLog::read_log, it entered this
code. can anyone tell me which situation will cause such a problem?
and how can i repair this osd or just remove it? Thanks.

    for (map<eversion_t, hobject_t>::reverse_iterator i =
           divergent_priors.rbegin();
         i != divergent_priors.rend();
         ++i) {
      if (i->first <= info.last_complete) break;
      if (i->second > info.last_backfill) continue;
      if (did.count(i->second)) continue;
      did.insert(i->second);
      bufferlist bv;
      int r = store->getattr(
        pg_coll,
        ghobject_t(i->second, ghobject_t::NO_GEN, info.pgid.shard),
        OI_ATTR,
        bv);
      if (r >= 0) {
        object_info_t oi(bv);
        /**
         * 1) we see this entry in the divergent priors mapping
         * 2) we didn't see an entry for this object in the log
         *
         * From 1 & 2 we know that either the object does not exist
         * or it is at the version specified in the divergent_priors
         * map since the object would have been deleted atomically
         * with the addition of the divergent_priors entry, an older
         * version would not have been recovered, and a newer version
         * would show up in the log above.
         */
        assert(oi.version == i->first);
      } else {
        dout(15) << "read_log  missing " << *i << dendl;
        missing.add(i->second, i->first, eversion_t());
      }
    }

From: "Piotr.Dalek@ts.fujitsu.com" <Piotr.Dalek@ts.fujitsu.com>
Subject: RE: reducing buffer allocations
Date: Fri, 5 Feb 2016 08:33:47 +0000
Message-ID: <30c783f799a044d7b6f4844b1f79b52f@R01UKEXCASM115.r01.fujitsu.local>
References: <alpine.DEB.2.11.1602041730260.28396@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail1.bemta14.messagelabs.com ([193.109.254.116]:47541 "EHLO
	mail1.bemta14.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751105AbcBEIeB convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 5 Feb 2016 03:34:01 -0500
In-Reply-To: <alpine.DEB.2.11.1602041730260.28396@cpach.fuggernut.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> owner@vger.kernel.org] On Behalf Of Sage Weil
> Sent: Thursday, February 04, 2016 11:33 PM
> To: ceph-devel@vger.kernel.org
> Subject: reducing buffer allocations
>=20
> https://github.com/ceph/ceph/pull/5534
>=20
> does two things: (1) combine the buffer::raw reference count and buff=
er
> into a single allocation (ala make_shared), and (2) convert buffer::l=
ist into an
> intrusive_list, while embedding N (=3D3) buffer::ptr's in the buffer:=
:raw so that
> most buffers require only 1 allocation (provided they aren't on more =
than N
> lists).
>=20
> This needs a rebase, and some benchmarking.  But before I pull it up,=
 is this
> the right direction?  I saw little benefit from (2) after doing (1), =
but I was
> doing a really simple microbenchmark.  Do we want both, or just 1, or=
 is there
> an alternative we should consider?

If that adds something to discussion, I found out that during my rados =
bench runs, bufferlists contain *up to* 1 bufferptr 80% of time, and si=
nce bufferlists are routinely used even as a temporary storage, in many=
 cases they're (bufferlists and bufferptrs) allocated and freed within =
the same function or thread, so that might be reason for odd perf resul=
ts.
One thing that we're missing for sure, is something that is bufferlist-=
compatible (so we could pass their iterators to existing encode() and d=
ecode() functions) and is not so elaborate - prime example would be key=
/value store code, where we have stuff like

(https://github.com/ceph/ceph/blob/master/src/kv/LevelDBStore.cc#L250)

  KeyValueDB::Iterator it =3D get_iterator(prefix);
  for (std::set<string>::const_iterator i =3D keys.begin();
       i !=3D keys.end();
       ++i) {
    it->lower_bound(*i);
    if (it->valid() && it->key() =3D=3D *i) {
      out->insert(make_pair(*i, it->value()));
    } else if (!it->valid())
      break;
  }

(https://github.com/ceph/ceph/blob/master/src/kv/LevelDBStore.h#L298)

And it->value() is:

    bufferlist value() {
      return to_bufferlist(dbiter->value());
    }

=46inally, to_bufferlist() is:

(https://github.com/ceph/ceph/blob/master/src/kv/LevelDBStore.cc#L294)

bufferlist LevelDBStore::to_bufferlist(leveldb::Slice in)
{
  bufferlist bl;
  bl.append(bufferptr(in.data(), in.size()));
  return bl;
}

So, in the end, we're constructing such monstrosity:

+----------------+
|   bufferlist   |
+----------------+        +-----------+
| _buffers       | ------ | bufferptr |
| _len           |        +-----------+         +--------------+
| _memcopy_count |        | raw*      |  ------ + buffer::raw  |
| append_buffer  |        | _off      |         +--------------+
+----------------+        | _len      |         | *data        | ---- {=
 actual data }
                          +-----------+         | len          |
                                                | nref         |
                                                | crc_spinlock |
                                                | crc_map      |
                                                +--------------+

(see http://ceph.predictor.org.pl/bufferptr.txt if Outlook screws up th=
e above ascii art)

My point here is that Ceph is using bufferlists not only in cases where=
 it needs to store non-contiguous memory areas as logically-contiguous =
one, but also for single, self-contained blocks of data. But, there's n=
o other choice yet when someone wants to get data off RocksDB/LevelDB a=
nd parse it using existing encode()/decode() functions.

Sage's idea (again, consult above link if my ascii-art won't line up):

+----------------------+
|     bufferlist       |
+----------------------+=20
| _buffers             |=20
| _len                 |=20
| _memcopy_count       |=20
| append_buffer        |=20
| +------------------+ |=20
| |    bufferptr     | |=20
| +------------------+ |=20
| | +--------------+ | |
| | + buffer::raw  | | |
| | +--------------+ | |
| | | *data        | | |  ---- { actual data }
| | | len          | | |
| | | nref         | | |
| | | crc_spinlock | | |
| | | crc_map      | | |=20
| | +--------------+ | |=20
| | _len             | |
| | _off             | |
| +------------------+ |=20
|                      |
| +------------------+ |=20
| |    bufferptr     | |=20
| +------------------+ |=20
| | +--------------+ | |
| | + buffer::raw  | | |
| | +--------------+ | |
| | | *data        | | |  ---- { actual data }
| | | len          | | |
| | | nref         | | |
| | | crc_spinlock | | |
| | | crc_map      | | |=20
| | +--------------+ | |=20
| | _len             | |
| | _off             | |
| +------------------+ |=20
|                      |
| +------------------+ |=20
| |    bufferptr     | |=20
| +------------------+ |=20
| | +--------------+ | |
| | + buffer::raw  | | |
| | +--------------+ | |
| | | *data        | | |  ---- { actual data }
| | | len          | | |
| | | nref         | | |
| | | crc_spinlock | | |
| | | crc_map      | | |=20
| | +--------------+ | |=20
| | _len             | |
| | _off             | |
| +------------------+ |=20
|                      |
+----------------------+

This is clearly a step forward from the previous design... and a step-b=
ack at the same time. For the case of fragmented bufferlists (like thos=
e used by messengers, with header, payload and footer being in separate=
 bufferptrs) this reduces allocation count by six (we have already allo=
cated all three bufferptrs and raws), but in case of K/V store, we're w=
asting memory for two bufferptrs and raws (around 160 bytes, if I'm cal=
culating correctly). This starts to get interesting when you consider s=
tructures like

struct pg_log_entry_t {
[..]
  // describes state for a locally-rollbackable entry
  ObjectModDesc mod_desc;
  bufferlist snaps;   // only for clone entries <------ *here*
  hobject_t  soid;
  osd_reqid_t reqid;  // caller+tid to uniquely identify request
  vector<pair<osd_reqid_t, version_t> > extra_reqids;
  eversion_t version, prior_version, reverting_to;
  version_t user_version; // the user version for this entry
  utime_t     mtime;  // this is the _user_ mtime, mind you

  __s32      op;
  bool invalid_hash; // only when decoding sobject_t based entries
  bool invalid_pool; // only when decoding pool-less hobject based entr=
ies
[..]

Since we're storing tens of thousands of such things in single OSD memo=
ry, and cases where one physical server hosts just one OSD are rare, th=
ose 160 bytes starts to add up really quickly.

With best regards / Pozdrawiam
Piotr Da=B3ek

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

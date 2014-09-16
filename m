From: "Ma, Jianpeng" <jianpeng.ma@intel.com>
Subject: RE: [PATCH 2/3] ec: make use of added aligned buffers
Date: Tue, 16 Sep 2014 08:23:03 +0000
Message-ID: <6AA21C22F0A5DA478922644AD2EC308C8C796E@SHSMSX101.ccr.corp.intel.com>
References: <1410796508-28711-1-git-send-email-j@jannau.net>
 <1410796508-28711-2-git-send-email-j@jannau.net>
 <54171FDD.4070701@dachary.org>
 <6AA21C22F0A5DA478922644AD2EC308C8C77BB@SHSMSX101.ccr.corp.intel.com>
 <alpine.DEB.2.00.1409151701490.20829@cobra.newdream.net>
 <6AA21C22F0A5DA478922644AD2EC308C8C77D4@SHSMSX101.ccr.corp.intel.com>
 <5417DCEB.8050805@dachary.org>
 <6AA21C22F0A5DA478922644AD2EC308C8C7911@SHSMSX101.ccr.corp.intel.com>
 <5417ECDF.3090706@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:26595 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752360AbaIPIXG convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Sep 2014 04:23:06 -0400
In-Reply-To: <5417ECDF.3090706@dachary.org>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I see it .Thanks very much!

Jianpeng
> -----Original Message-----
> From: Loic Dachary [mailto:loic@dachary.org]
> Sent: Tuesday, September 16, 2014 3:55 PM
> To: Ma, Jianpeng
> Cc: ceph-devel@vger.kernel.org
> Subject: Re: [PATCH 2/3] ec: make use of added aligned buffers
>=20
>=20
>=20
> On 16/09/2014 08:59, Ma, Jianpeng wrote:
> >> -----Original Message-----
> >> From: Loic Dachary [mailto:loic@dachary.org]
> >> Sent: Tuesday, September 16, 2014 2:47 PM
> >> To: Ma, Jianpeng
> >> Cc: ceph-devel@vger.kernel.org
> >> Subject: Re: [PATCH 2/3] ec: make use of added aligned buffers
> >>
> >>
> >>
> >> On 16/09/2014 02:08, Ma, Jianpeng wrote:
> >>>> -----Original Message-----
> >>>> From: Sage Weil [mailto:sweil@redhat.com]
> >>>> Sent: Tuesday, September 16, 2014 8:02 AM
> >>>> To: Ma, Jianpeng
> >>>> Cc: Loic Dachary; Janne Grunau; ceph-devel@vger.kernel.org
> >>>> Subject: RE: [PATCH 2/3] ec: make use of added aligned buffers
> >>>>
> >>>> On Mon, 15 Sep 2014, Ma, Jianpeng wrote:
> >>>>> If we modify bufferlist::c_str()  to bufferlist::c_str(bool ali=
gn).
> >>>>> If (align)
> >>>>>   Posix_memalign(data, CEPH_PAGE_SIZE, len) Else
> >>>>>   Origin code.
> >>>>
> >>>> Alignment isn't really a bool, it's an int.  c_str(int align=3D1=
) ?
> >>>>
> >>> I mean if we need a align memory after bufferlist::c_str. We can =
set
> >>> the align =3D true; Now bufferlist::c_str depend on the size when
> >>> using rebuild if
> >> bufferlist have more prt.
> >>>
> >>> BTW, we also can change the rebuild() && rebuild(ptr). Merge two
> >>> func into
> >> one rebuild(bool align).
> >>> By judge the parameter align to alloc align memory or not.
> >>>
> >>> Or am I missing something?
> >>
> >> I don't think there is a need for c_str(int align). We make every
> >> effort to allocate buffers that are properly aligned. If c_str() d=
oes
> >> not return an aligned buffer, the proper fix is to align the
> >> allocated buffer at the source, not to allocate a new aligned buff=
er and copy
> the content of the non aligned buffer into it.
> >>
> >
> >> Do you see a reason why that would be a bad way to deal with align=
ment ?
> >  We only guarantee memory align after c_str and don't depend on the
> previous steps.
>=20
> This is a benefit indeed: less room for error in general.
>=20
> > If encode[i] have more ptr suppose they all aligned memory.
> > But how to guarantee aligned memory after c_str.
> > If bufferlist have more ptr, the aligned memory depend on the size =
of
> bufferlist.
>=20
> The ErasureCode::encode_prepare prepares the allocated buffer so that
>=20
> *) it holds enough room to contain all chunks
> *) c_str() on a chunk boundary will return a pointer that does not re=
quire
> allocating memory
>=20
> The ErasureCodeJerasure::get_chunk_size function determines the size =
of the
> buffer allocated by encode_prepare and further guarantees that each c=
hunk is:
>=20
> *) size aligned on 16 bytes
> *) memory aligned on 16 bytes so that SIMD instructions can use it wi=
thout
> moving it
>=20
> In other words, if c_str() had to re-allocate the buffer because it i=
s not aligned,
> it would mean that the allocation of the buffer is not done as it sho=
uld.
>=20

> Cheers
>=20
> > Jianpeng
> >>
> >> Cheers
> >>
> >>>
> >>> Jianpeng
> >>>> sage
> >>>>
> >>>>>
> >>>>> I think this is simple and correctly code.
> >>>>>
> >>>>> Jianpeng
> >>>>> Thanks!
> >>>>>
> >>>>>> -----Original Message-----
> >>>>>> From: ceph-devel-owner@vger.kernel.org
> >>>>>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Loic
> >>>>>> Dachary
> >>>>>> Sent: Tuesday, September 16, 2014 1:20 AM
> >>>>>> To: Janne Grunau; ceph-devel@vger.kernel.org
> >>>>>> Subject: Re: [PATCH 2/3] ec: make use of added aligned buffers
> >>>>>>
> >>>>>> Hi Janne,
> >>>>>>
> >>>>>> See below:
> >>>>>>
> >>>>>> On 15/09/2014 17:55, Janne Grunau wrote:
> >>>>>>> Requiring page aligned buffers and realigning the input if
> >>>>>>> necessary creates measurable oberhead.
> >> ceph_erasure_code_benchmark
> >>>>>>> is ~30% faster with this change for technique=3Dreed_sol_van,=
k=3D2,m=3D1.
> >>>>>>>
> >>>>>>> Also prevents a misaligned buffer when
> >>>>>>> bufferlist::c_str(bufferlist) has to allocate a new buffer to
> >>>>>>> provide continuous one. See bug #9408
> >>>>>>>
> >>>>>>> Signed-off-by: Janne Grunau <j@jannau.net>
> >>>>>>> ---
> >>>>>>>  src/erasure-code/ErasureCode.cc | 46
> >>>>>>> +++++++++++++++++++++++++----------------
> >>>>>>>  src/erasure-code/ErasureCode.h  |  3 ++-
> >>>>>>>  2 files changed, 30 insertions(+), 19 deletions(-)
> >>>>>>>
> >>>>>>> diff --git a/src/erasure-code/ErasureCode.cc
> >>>>>>> b/src/erasure-code/ErasureCode.cc index 5953f49..078f60b 1006=
44
> >>>>>>> --- a/src/erasure-code/ErasureCode.cc
> >>>>>>> +++ b/src/erasure-code/ErasureCode.cc
> >>>>>>> @@ -54,22 +54,38 @@ int
> >>>>>> ErasureCode::minimum_to_decode_with_cost(const
> >>>>>>> set<int> &want_to_read,  }
> >>>>>>>
> >>>>>>>  int ErasureCode::encode_prepare(const bufferlist &raw,
> >>>>>>> -                                bufferlist *prepared) const
> >>>>>>> +                                map<int, bufferlist>
> &encoded)
> >>>>>> const
> >>>>>>>  {
> >>>>>>>    unsigned int k =3D get_data_chunk_count();
> >>>>>>>    unsigned int m =3D get_chunk_count() - k;
> >>>>>>>    unsigned blocksize =3D get_chunk_size(raw.length());
> >>>>>>> -  unsigned padded_length =3D blocksize * k;
> >>>>>>> -  *prepared =3D raw;
> >>>>>>> -  if (padded_length - raw.length() > 0) {
> >>>>>>> -    bufferptr pad(padded_length - raw.length());
> >>>>>>> -    pad.zero();
> >>>>>>> -    prepared->push_back(pad);
> >>>>>>> +  unsigned pad_len =3D blocksize * k - raw.length();
> >>>>>>> +
> >>>>>>> +  bufferlist prepared =3D raw;
> >>>>>>> +
> >>>>>>> +  if (!prepared.is_aligned()) {
> >>>>>>> +    prepared.rebuild_aligned();  }
> >>>>>>> +
> >>>>>>> +  for (unsigned int i =3D 0; i < k - !!pad_len; i++) {
> >>>>>>> +    int chunk_index =3D chunk_mapping.size() > 0 ? chunk_map=
ping[i] :
> i;
> >>>>>>> +    bufferlist &chunk =3D encoded[chunk_index];
> >>>>>>> +    chunk.substr_of(prepared, i * blocksize, blocksize);  }
> >>>>>>
> >>>>>> It is possible for more than one chunk to be padding. It's a
> >>>>>> border case but... for instance with alignment =3D 16, k=3D12 =
and in
> >>>>>> of length
> >>>>>> 1550 you end up with two padding chunks because the blocksize =
is 144.
> >>>>>>
> >>>>>>> +  if (pad_len > 0) {
> >>>>>>> +    int chunk_index =3D chunk_mapping.size() > 0 ?
> >>>>>>> + chunk_mapping[k
> >>>>>>> + - 1] : k -
> >>>>>> 1;
> >>>>>>> +    bufferlist &chunk =3D encoded[chunk_index];
> >>>>>>> +    bufferptr padded(buffer::create_aligned(blocksize));
> >>>>>>> +    raw.copy((k - 1) * blocksize, blocksize - pad_len, padde=
d.c_str());
> >>>>>>> +    padded.zero(blocksize - pad_len, pad_len);
> >>>>>>> +    chunk.push_back(padded);
> >>>>>>>    }
> >>>>>>> -  unsigned coding_length =3D blocksize * m;
> >>>>>>> -  bufferptr coding(buffer::create_page_aligned(coding_length=
));
> >>>>>>> -  prepared->push_back(coding);
> >>>>>>> -  prepared->rebuild_page_aligned();
> >>>>>>> +  for (unsigned int i =3D k; i < k + m; i++) {
> >>>>>>> +    int chunk_index =3D chunk_mapping.size() > 0 ? chunk_map=
ping[i] :
> i;
> >>>>>>> +    bufferlist &chunk =3D encoded[chunk_index];
> >>>>>>> +    chunk.push_back(buffer::create_aligned(blocksize));
> >>>>>>> +  }
> >>>>>>> +
> >>>>>>>    return 0;
> >>>>>>>  }
> >>>>>>>
> >>>>>>> @@ -80,15 +96,9 @@ int ErasureCode::encode(const set<int>
> >>>>>> &want_to_encode,
> >>>>>>>    unsigned int k =3D get_data_chunk_count();
> >>>>>>>    unsigned int m =3D get_chunk_count() - k;
> >>>>>>>    bufferlist out;
> >>>>>>> -  int err =3D encode_prepare(in, &out);
> >>>>>>> +  int err =3D encode_prepare(in, *encoded);
> >>>>>>>    if (err)
> >>>>>>>      return err;
> >>>>>>> -  unsigned blocksize =3D get_chunk_size(in.length());
> >>>>>>> -  for (unsigned int i =3D 0; i < k + m; i++) {
> >>>>>>> -    int chunk_index =3D chunk_mapping.size() > 0 ? chunk_map=
ping[i] :
> i;
> >>>>>>> -    bufferlist &chunk =3D (*encoded)[chunk_index];
> >>>>>>> -    chunk.substr_of(out, i * blocksize, blocksize);
> >>>>>>> -  }
> >>>>>>>    encode_chunks(want_to_encode, encoded);
> >>>>>>>    for (unsigned int i =3D 0; i < k + m; i++) {
> >>>>>>>      if (want_to_encode.count(i) =3D=3D 0) diff --git
> >>>>>>> a/src/erasure-code/ErasureCode.h
> >>>>>>> b/src/erasure-code/ErasureCode.h index 7aaea95..62aa383 10064=
4
> >>>>>>> --- a/src/erasure-code/ErasureCode.h
> >>>>>>> +++ b/src/erasure-code/ErasureCode.h
> >>>>>>> @@ -46,7 +46,8 @@ namespace ceph {
> >>>>>>>                                              const
> map<int,
> >>>> int>
> >>>>>> &available,
> >>>>>>>                                              set<int>
> >>>> *minimum);
> >>>>>>>
> >>>>>>> -    int encode_prepare(const bufferlist &raw, bufferlist *pr=
epared)
> >>>> const;
> >>>>>>> +    int encode_prepare(const bufferlist &raw,
> >>>>>>> +                       map<int, bufferlist> &encoded) const;
> >>>>>>>
> >>>>>>>      virtual int encode(const set<int> &want_to_encode,
> >>>>>>>                         const bufferlist &in,
> >>>>>>>
> >>>>>>
> >>>>>> --
> >>>>>> Lo?c Dachary, Artisan Logiciel Libre
> >>>>>
> >>>>> --
> >>>>> To unsubscribe from this list: send the line "unsubscribe ceph-=
devel"
> >>>>> in the body of a message to majordomo@vger.kernel.org More
> >>>>> majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>>>>
> >>>>>
> >>> --
> >>> To unsubscribe from this list: send the line "unsubscribe ceph-de=
vel"
> >>> in the body of a message to majordomo@vger.kernel.org More majord=
omo
> >>> info at  http://vger.kernel.org/majordomo-info.html
> >>>
> >>
> >> --
> >> Lo=EFc Dachary, Artisan Logiciel Libre
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l"
> > in the body of a message to majordomo@vger.kernel.org More majordom=
o
> > info at  http://vger.kernel.org/majordomo-info.html
> >
>=20
> --
> Lo=EFc Dachary, Artisan Logiciel Libre

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

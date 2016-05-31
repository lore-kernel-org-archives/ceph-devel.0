From: Piotr =?utf-8?B?RGHFgmVr?= <branch@predictor.org.pl>
Subject: Re: RocksDB Incorrect API Usage
Date: Tue, 31 May 2016 19:17:29 +0200
Message-ID: <20160531171729.GC20357@predictor>
References: <CACJqLyYtHkeQ+jSNi7JPJzRb6wfCcNAuCSr_YyTwdqA_kzzP_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from predictor.org.pl ([185.5.97.54]:45078 "EHLO predictor.org.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755275AbcEaRPI (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 31 May 2016 13:15:08 -0400
Content-Disposition: inline
In-Reply-To: <CACJqLyYtHkeQ+jSNi7JPJzRb6wfCcNAuCSr_YyTwdqA_kzzP_g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Jun 01, 2016 at 12:49:53AM +0800, Haomai Wang wrote:
> Hi Sage and Mark,
>=20
> As mentioned in BlueStore standup, I found rocksdb iterator *Seek*
> won't use bloom filter like *Get*.
>=20
> *Get* impl: it will look at filter firstly
> https://github.com/facebook/rocksdb/blob/master/table/block_based_tab=
le_reader.cc#L1369
>=20
> Iterator *Seek*: it will do binary search, by default we don't specif=
y
> prefix feature(https://github.com/facebook/rocksdb/wiki/Prefix-Seek-A=
PI-Changes).
> https://github.com/facebook/rocksdb/blob/master/table/block.cc#L94
>=20
> [..]
> --- a/db/db_bench.cc
> +++ b/db/db_bench.cc
> @@ -2923,14 +2923,12 @@ class Benchmark {
>          int64_t key_rand =3D thread->rand.Next() & (pot - 1);
>          GenerateKeyFromInt(key_rand, FLAGS_num, &key);
>          ++read;
> -        auto status =3D db->Get(options, key, &value);
> -        if (status.ok()) {
> -          ++found;
> -        } else if (!status.IsNotFound()) {
> -          fprintf(stderr, "Get returned an error: %s\n",
> -                  status.ToString().c_str());
> -          abort();
> -        }
> +        Iterator* iter =3D db->NewIterator(options);
> +      iter->Seek(key);
> +      if (iter->Valid() && iter->key().compare(key) =3D=3D 0) {
> +        found++;
> +      }
> +
>          if (key_rand >=3D FLAGS_num) {
>            ++nonexist;
>          }

Aren't you missing "delete iter" here?

--=20
Piotr Da=C5=82ek
branch@predictor.org.pl
http://blog.predictor.org.pl
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

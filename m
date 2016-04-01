From: Allen Samuels <Allen.Samuels@sandisk.com>
Subject: RE: Adding compression support for bluestore.
Date: Fri, 1 Apr 2016 18:54:19 +0000
Message-ID: <CY1PR0201MB1897E62699025390EBB961A5E89A0@CY1PR0201MB1897.namprd02.prod.outlook.com>
References: <56C1FCF3.4030505@mirantis.com>
 <CACJqLyb=X1i7tsYeKOEJRdJEEMBGvgW817eY5Bo9YBXDszUDmw@mail.gmail.com>
 <56C3BAA3.3070804@mirantis.com>
 <CY1PR0201MB1897E7F1DE04B5E4577B16EDE8A00@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1602220718380.13988@cpach.fuggernut.com>
 <56CDF40C.9060405@mirantis.com>
 <CY1PR0201MB1897BC7052AD6F7FB01DCAB4E8A50@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <56D08E30.20308@mirantis.com>
 <alpine.DEB.2.11.1603151243030.32086@cpach.fuggernut.com>
 <56E9A727.1030400@mirantis.com>
 <alpine.DEB.2.11.1603161515360.14377@cpach.fuggernut.com>
 <56EACAAD.90002@mirantis.com>
 <alpine.DEB.2.11.1603171123090.14377@cpach.fuggernut.com>
 <56EC248E.3060502@mirantis.com>
 <CY1PR0201MB1897035E6E09FE518ACC2DDCE88D0@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <56F013FB.4040002@mirantis.com>
 <alpine.DEB.2.11.1603211141560.23875@cpach.fuggernut.com>
 <56F3E157.2090004@mirantis.com>
 <alpine.DEB.2.11.1603311746080.4670@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2on0072.outbound.protection.outlook.com ([207.46.100.72]:22964
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751318AbcDASyW convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Apr 2016 14:54:22 -0400
In-Reply-To: <alpine.DEB.2.11.1603311746080.4670@cpach.fuggernut.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, Igor Fedotov <ifedotov@mirantis.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Rather than having a flag in the lextent to indicate sharing, I would propose that we use a signed pextent_id, with positive values for unshared (stored in onode) blobs and negative values for shared blobs.

This provides safety in the code, if you incorrect forget to test the shared flag, then when you lookup the pextent_id it'll fail, unless you look it up in the right place....

Also, it shouldn't be pextent_id, but rather pblob_id. :) 


Allen Samuels
Software Architect, Fellow, Systems and Software Solutions 

2880 Junction Avenue, San Jose, CA 95134
T: +1 408 801 7030| M: +1 408 780 6416
allen.samuels@SanDisk.com


> -----Original Message-----
> From: Sage Weil [mailto:sage@newdream.net]
> Sent: Thursday, March 31, 2016 2:56 PM
> To: Igor Fedotov <ifedotov@mirantis.com>
> Cc: Allen Samuels <Allen.Samuels@sandisk.com>; ceph-devel <ceph-
> devel@vger.kernel.org>
> Subject: Re: Adding compression support for bluestore.
> 
> How about this:
> 
> // in the onode:
> map<uint64_t, bluestore_lextent_t> data_map; map<int, bluestore_blob_t>
> blob_map;
> 
> // in the enode
> map<int, bluestore_blob_t> blob_map;
> 
> struct bluestore_lextent_t {
>   enum {
>     FLAG_SHARED = 1,        ///< pextent lives in enode
>   };
> 
>   uint64_t logical_length;  ///< length of logical bytes we represent
>   uint32_t pextent_id;      ///< id of pextent in onode or enode
>   uint32_t x_off, x_len;    ///< relative portion of pextent with our data
>   uint32_t flags;           ///< FLAG_*
> };
> 
> struct bluestore_pextent_t {
>   uint64_t offset;          ///< offset on disk
>   uint64_t length;          ///< length on disk
> };
> 
> struct bluestore_blob_t {
>   enum {
>     CSUM_XXHASH32 = 1,
>     CSUM_XXHASH64 = 2,
>     CSUM_CRC32C = 3,
>     CSUM_CRC16 = 4,
>   };
>   enum {
>     FLAG_IMMUTABLE = 1,     ///< no overwrites allowed
>     FLAG_COMPRESSED = 2,    ///< extent is compressed; alg is in first byte of
> data
>   };
>   enum {
>     COMP_ZLIB = 1,
>     COMP_SNAPPY = 2,
>     COMP_LZO = 3,
>   };
> 
>   vector<bluestore_pextent_t> extents;  ///< extents on disk
>   uint32_t logical_length;              ///< uncompressed length
>   uint32_t flags;                       ///< FLAG_*
>   uint8_t csum_type;                    ///< CSUM_*
>   uint8_t csum_block_order;
>   uint16_t num_refs;               ///< reference count (always 1 when in onode)
>   vector<char> csum_data;          ///< opaque vector of csum data
> 
>   uint32_t get_ondisk_length() const {
>     uint32_t len = 0;
>     for (auto &p : extentes) {
>       len += p.length;
>     }
>     return len;
>   }
> 
>   uint32_t get_csum_block_size() const {
>     return 1 << csum_block_order;
>   }
>   size_t get_csum_value_size() const {
>     switch (csum_type) {
>     case CSUM_XXHASH32: return 4;
>     case CSUM_XXHASH64: return 8;
>     case CSUM_CRC32C: return 4;
>     case CSUM_CRC16: return 2;
>     default: return 0;
>     }
>   }
> 
>   // assert (ondisk_length / csum_block_size) * csum_value_size ==
>   // csum_data.length()
> };

From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Re: BlueStore in-memory Onode footprint
Date: Fri, 16 Dec 2016 19:12:30 +0300
Message-ID: <b2590168-0df7-d95a-ebc4-608ae60fc2f0@mirantis.com>
References: <34ee2613-8db3-646e-4470-b3e8fa8855e0@mirantis.com>
 <alpine.DEB.2.11.1612161518570.10615@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yb0-f176.google.com ([209.85.213.176]:34581 "EHLO
        mail-yb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751334AbcLPQNZ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Dec 2016 11:13:25 -0500
Received: by mail-yb0-f176.google.com with SMTP id d59so40304085ybi.1
        for <ceph-devel@vger.kernel.org>; Fri, 16 Dec 2016 08:12:47 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1612161518570.10615@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Here is mempool's detailed report:

BTW. bluestore_alloc pool's stats look suspicious too.

"total": {
             "items": 1529590,
             "bytes": 18036016
         },


mempool dump:
{
     "buffer_meta": {
         "total": {
             "items": 4,
             "bytes": 384
         },
         "ceph::buffer::raw_char": {
             "items": 0,
             "bytes": 0
         },
         "ceph::buffer::raw_malloc": {
             "items": 0,
             "bytes": 0
         },
         "ceph::buffer::raw_mmap_pages": {
             "items": 0,
             "bytes": 0
         },
         "ceph::buffer::raw_pipe": {
             "items": 0,
             "bytes": 0
         },
         "ceph::buffer::raw_posix_aligned": {
             "items": 4,
             "bytes": 384
         },
         "ceph::buffer::raw_static": {
             "items": 0,
             "bytes": 0
         },
         "ceph::buffer::raw_unshareable": {
             "items": 0,
             "bytes": 0
         }
     },
     "buffer_data": {
         "total": {
             "items": 2105456,
             "bytes": 2105456
         },
         "char": {
             "items": 2105456,
             "bytes": 2105456
         }
     },
     "osd": {
         "total": {
             "items": 0,
             "bytes": 0
         }
     },
     "bluestore_meta_onode": {
         "total": {
             "items": 1,
             "bytes": 704
         },
         "BlueStore::Onode": {
             "items": 1,
             "bytes": 704
         }
     },
     "bluestore_meta_other": {
         "total": {
             "items": 4120,
             "bytes": 574760
         },
         "BlueStore::Blob": {
             "items": 1024,
             "bytes": 253952
         },
         "BlueStore::Buffer": {
             "items": 0,
             "bytes": 0
         },
         "BlueStore::Extent": {
             "items": 1024,
             "bytes": 49152
         },
         "BlueStore::ExtentMap::Shard": {
             "items": 18,
             "bytes": 1008
         },
         "BlueStore::SharedBlob": {
             "items": 1024,
             "bytes": 221184
         },
         "std::_Rb_tree_node<std::pair<int const, 
boost::intrusive_ptr<BlueStore::Blob> > >": {
             "items": 0,
             "bytes": 0
         },
         "std::_Rb_tree_node<std::pair<unsigned long const, 
bluestore_extent_ref_map_t::record_t> >": {
             "items": 1024,
             "bytes": 49152
         },
         "std::_Rb_tree_node<std::pair<unsigned long const, 
std::unique_ptr<BlueStore::Buffer, 
std::default_delete<BlueStore::Buffer> > > >": {
             "items": 0,
             "bytes": 0
         },
         "std::__detail::_Hash_node<std::pair<coll_t const, 
boost::intrusive_ptr<BlueStore::Collection> >, true>": {
             "items": 1,
             "bytes": 112
         },
         "std::__detail::_Hash_node<std::pair<ghobject_t const, 
boost::intrusive_ptr<BlueStore::Onode> >, true>": {
             "items": 1,
             "bytes": 168
         },
         "std::__detail::_Hash_node<std::pair<unsigned long const, 
BlueStore::SharedBlob*>, false>": {
             "items": 0,
             "bytes": 0
         },
         "std::__detail::_Hash_node_base*": {
             "items": 4,
             "bytes": 32
         },
         "std::pair<coll_t const, 
boost::intrusive_ptr<BlueStore::Collection> >": {
             "items": 0,
             "bytes": 0
         },
         "std::pair<ghobject_t const, 
boost::intrusive_ptr<BlueStore::Onode> >": {
             "items": 0,
             "bytes": 0
         }
     },
     "bluestore_alloc": {
         "total": {
             "items": 1529590,
             "bytes": 18036016
         },
         "AllocExtent": {
             "items": 0,
             "bytes": 0
         },
         "BitAllocator": {
             "items": 2,
             "bytes": 464
         },
         "BitMapArea": {
             "items": 0,
             "bytes": 0
         },
         "BitMapAreaIN": {
             "items": 0,
             "bytes": 0
         },
         "BitMapAreaLeaf": {
             "items": 438,
             "bytes": 45552
         },
         "BitMapZone": {
             "items": 89950,
             "bytes": 6476400
         },
         "BmapEntry": {
             "items": 1439200,
             "bytes": 11513600
         }
     },
     "bluefs": {
         "total": {
             "items": 65,
             "bytes": 3744
         },
         "BlueFS::Dir": {
             "items": 1,
             "bytes": 88
         },
         "BlueFS::File": {
             "items": 9,
             "bytes": 1368
         },
         "BlueFS::FileLock": {
             "items": 1,
             "bytes": 8
         },
         "BlueFS::FileReader": {
             "items": 1,
             "bytes": 128
         },
         "BlueFS::FileReaderBuffer": {
             "items": 0,
             "bytes": 0
         },
         "BlueFS::FileWriter": {
             "items": 3,
             "bytes": 960
         },
         "bluefs_extent_t": {
             "items": 9,
             "bytes": 144
         },
"std::_Rb_tree_node<std::pair<std::__cxx11::basic_string<char, 
std::char_traits<char>, std::allocator<char> > const, 
boost::intrusive_ptr<BlueFS::Dir> > >": {
             "items": 1,
             "bytes": 72
         },
"std::_Rb_tree_node<std::pair<std::__cxx11::basic_string<char, 
std::char_traits<char>, std::allocator<char> > const, 
boost::intrusive_ptr<BlueFS::File> > >": {
             "items": 8,
             "bytes": 576
         },
         "std::__detail::_Hash_node<std::pair<unsigned long const, 
boost::intrusive_ptr<BlueFS::File> >, false>": {
             "items": 9,
             "bytes": 216
         },
         "std::__detail::_Hash_node_base*": {
             "items": 23,
             "bytes": 184
         },
         "std::pair<unsigned long const, 
boost::intrusive_ptr<BlueFS::File> >": {
             "items": 0,
             "bytes": 0
         }
     }
}


On 16.12.2016 18:20, Sage Weil wrote:
> On Fri, 16 Dec 2016, Igor Fedotov wrote:
>> Hey All!
>>
>> Recently I realized that I'm unable to fit all my onodes ( 32768 objects/4Mb
>> each/4K alloc unit/no csum) in 15G RAM cache.
>>
>> Hence decided to estimate Onode in-memory size.
>>
>> At first I filled 4Mb object with a single 4M write - mempools indicate ~5K
>> mem usage for total onode metadata. Good enough.
>>
>> Secondly I refill that object with 4K writes. Resulting memusage = 574K!!!
>> Onode itself 704 bytes in 1 object.  And 4120 other metadata items occupies
>> all other space.
>>
>> Then I removed SharedBlob from mempools. Resulting mem usage = 355K. The same
>> Onode size. And 3096 other metadata objects. Hence we had 1024 SharedBlob
>> instances thata took ~ 220K.
>>
>>
>> And finally I removed Blob instances from measurements. Resulting mem usage =
>> 99K. And 2072 other objects. Hence Blob instances take another ~250K
> Yikes!
>
> BTW you can get a full breakdown by type with 'mempool debug = true' in
> ceph.conf (-o 'mempool debug = true' on vstart.sh command line) without
> having to recompile.  Do you mind repeating the test and including the
> full breakdown?
>   
>> Yeah, that's the worst case( actually csum enable will give even more mem use)
>> but shouldn't we revisit some Onode internals due to such numbers?
> Yep!
>
> sage


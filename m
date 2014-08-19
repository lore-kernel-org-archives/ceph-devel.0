From: Yehuda Sadeh <yehuda@redhat.com>
Subject: Re: RadosGW crashing on copy for one specific object
Date: Tue, 19 Aug 2014 10:44:18 -0700
Message-ID: <CABBk=J8qLc45ggoqdWEZVi3YF0Og9wuj_5tW_5Gng+bh65rUjg@mail.gmail.com>
References: <CAF6-1L4zXmczyvXyD=1ZKjO67BYDoPMa3JEaKn082y5WUZY39w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:40661 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751625AbaHSRoT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Aug 2014 13:44:19 -0400
Received: by mail-ig0-f173.google.com with SMTP id h18so10407721igc.12
        for <ceph-devel@vger.kernel.org>; Tue, 19 Aug 2014 10:44:19 -0700 (PDT)
In-Reply-To: <CAF6-1L4zXmczyvXyD=1ZKjO67BYDoPMa3JEaKn082y5WUZY39w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylvain Munaut <s.munaut@whatever-company.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

What does 'radosgw-admin object stat --bucket=<bucket> --object=<object>' show?

Also, can you bump logging up? debug rgw = 20, debug ms = 1

Thanks,
Yehuda

On Tue, Aug 19, 2014 at 5:44 AM, Sylvain Munaut
<s.munaut@whatever-company.com> wrote:
> Hi,
>
>
> Today I have an issue when trying to issue a COPY for one object I
> have in RGW. It only happens for this object (at least that I noticed
> and I did 1000's of COPYs in this batch) and I can do a GET of this
> object just fine.
>
> The stack trace :
>
>  ceph version 0.80.5-173-g7429f00 (7429f00caaae3c6197e13786c13bc55055d16951)
>  1: /usr/bin/radosgw() [0x5cd19a]
>  2: (()+0xfcb0) [0x7f3806340cb0]
>  3: (()+0x142740) [0x7f3805598740]
>  4: (ceph::buffer::ptr::append(char const*, unsigned int)+0x43) [0x7f380724f5b3]
>  5: (ceph::buffer::list::append(char const*, unsigned int)+0x91)
> [0x7f3807251cf1]
>  6: (RGWRados::copy_obj_data(void*, std::string const&, void**, long,
> rgw_obj&, rgw_obj&, unsigned long, long*, std::map<std::string,
> ceph::buffer::list, std::less<std::string>,
> std::allocator<std::pair<std::string const, ceph::buffer::list> > >&,
> RGWObjCategory, std::string*, rgw_err*)+0x5cc) [0x52524c]
>  7: (RGWRados::copy_obj(void*, std::string const&, std::string const&,
> std::string const&, req_info*, std::string const&, rgw_obj&, rgw_obj&,
> RGWBucketInfo&, RGWBucketInfo&, long*, long const*, long const*, char
> const*, char const*, bool, std::map<std::string, ceph::buffer::list,
> std::less<std::string>, std::allocator<std::pair<std::string const,
> ceph::buffer::list> > >&, RGWObjCategory, std::string*, rgw_err*, void
> (*)(long, void*), void*)+0x19b5) [0x5336e5]
>  8: (RGWCopyObj::execute()+0x2bc) [0x557c0c]
>  9: /usr/bin/radosgw() [0x4c871c]
>  10: (RGWFCGXProcess::handle_request(RGWRequest*)+0x9c) [0x4c93fc]
>  11: (RGWProcess::RGWWQ::_process(RGWRequest*)+0x37) [0x4ca4e7]
>  12: (ThreadPool::worker(ThreadPool::WorkThread*)+0x4e6) [0x7f38072373f6]
>  13: (ThreadPool::WorkThread::entry()+0x10) [0x7f3807239200]
>  14: (()+0x7e9a) [0x7f3806338e9a]
>  15: (clone()+0x6d) [0x7f380554a73d]
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> needed to interpret this.
>
>
> This is the content of the OMAP key in the directory index :
>
> 0000000: 0503 3201 0000 4d00 0000 3561 6531 6238  ..2...M...5ae1b8
> 0000010: 6362 3861 3262 6463 3363 3264 3765 3138  cb8a2bdc3c2d7e18
> 0000020: 3638 6236 3064 3736 6162 6561 3235 3336  68b60d76abea2536
> 0000030: 6634 3630 3464 3664 3331 3264 6639 3562  f4604d6d312df95b
> 0000040: 3731 3934 3730 6662 3362 2f72 656e 6465  719470fb3b/rende
> 0000050: 722d 696d 6167 651b 0100 0000 0000 0001  r-image.........
> 0000060: 0303 5800 0000 0107 a903 0000 0000 0032  ..X............2
> 0000070: 7c3c 5300 0000 0022 0000 0062 6665 3264  |<S...."...bfe2d
> 0000080: 6638 3632 6439 3266 3730 6365 6362 6564  f862d92f70cecbed
> 0000090: 6261 6233 3234 6533 6637 382d 3102 0000  bab324e3f78-1...
> 00000a0: 006b 700a 0000 004b 5020 5333 2055 7365  .kp....KP S3 Use
> 00000b0: 7209 0000 0069 6d61 6765 2f70 6e67 0000  r....image/png..
> 00000c0: 0000 4d00 0000 3561 6531 6238 6362 3861  ..M...5ae1b8cb8a
> 00000d0: 3262 6463 3363 3264 3765 3138 3638 6236  2bdc3c2d7e1868b6
> 00000e0: 3064 3736 6162 6561 3235 3336 6634 3630  0d76abea2536f460
> 00000f0: 3464 3664 3331 3264 6639 3562 3731 3934  4d6d312df95b7194
> 0000100: 3730 6662 3362 2f72 656e 6465 722d 696d  70fb3b/render-im
> 0000110: 6167 6501 0104 0000 0023 821b 0136 1600  age......#...6..
> 0000120: 0000 6465 6661 756c 742e 3434 3034 3839  ..default.440489
> 0000130: 2e31 3539 3035 3436                      .1590546
>
>
> The head object (
> default.440489.58258_5ae1b8cb8a2bdc3c2d7e1868b60d76abea2536f4604d6d312df95b719470fb3b/render-image
> ) is empty (size=0) and the stored manifest (in the user.rgw.manifest
> xattr) :
>
> 0000000: 0202 5d01 0000 07a9 0300 0000 0000 0100  ..].............
> 0000010: 0000 0000 0000 0000 0000 0202 4301 0000  ............C...
> 0000020: 0303 2d01 0000 1800 0000 6b70 2d72 656e  ..-.......kp-ren
> 0000030: 6465 722d 696d 6167 652e 626f 7579 6775  der-image.bouygu
> 0000040: 6573 0000 0000 0900 0000 6d75 6c74 6970  es........multip
> 0000050: 6172 747a 0000 005f 6d75 6c74 6970 6172  artz..._multipar
> 0000060: 745f 3561 6531 6238 6362 3861 3262 6463  t_5ae1b8cb8a2bdc
> 0000070: 3363 3264 3765 3138 3638 6236 3064 3736  3c2d7e1868b60d76
> 0000080: 6162 6561 3235 3336 6634 3630 3464 3664  abea2536f4604d6d
> 0000090: 3331 3264 6639 3562 3731 3934 3730 6662  312df95b719470fb
> 00000a0: 3362 2f72 656e 6465 722d 696d 6167 652e  3b/render-image.
> 00000b0: 3872 5344 4438 4d56 4431 4b49 5844 5451  8rSDD8MVD1KIXDTQ
> 00000c0: 4473 6633 6736 6237 3164 7141 4450 5f2e  Dsf3g6b71dqADP_.
> 00000d0: 3106 037c 0000 0018 0000 006b 702d 7265  1..|.......kp-re
> 00000e0: 6e64 6572 2d69 6d61 6765 2e62 6f75 7967  nder-image.bouyg
> 00000f0: 7565 7314 0000 002e 7267 772e 6b70 2d72  ues.....rgw.kp-r
> 0000100: 656e 6465 722d 696d 6167 6514 0000 0064  ender-image....d
> 0000110: 6566 6175 6c74 2e34 3430 3438 392e 3538  efault.440489.58
> 0000120: 3235 3814 0000 0064 6566 6175 6c74 2e34  258....default.4
> 0000130: 3430 3438 392e 3538 3235 3814 0000 002e  40489.58258.....
> 0000140: 7267 772e 6b70 2d72 656e 6465 722d 696d  rgw.kp-render-im
> 0000150: 6167 6500 0000 0000 0000 0007 a903 0000  age.............
> 0000160: 0000 000a                                ....
>
> The actual file content is in :
>
> default.440489.58258__multipart_5ae1b8cb8a2bdc3c2d7e1868b60d76abea2536f4604d6d312df95b719470fb3b/render-image.8rSDD8MVD1KIXDTQDsf3g6b71dqADP_.1
>
> and is correct (if I fetch the object with rados, it's all there).
>
>
> Cheers,
>
>     Sylvain
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

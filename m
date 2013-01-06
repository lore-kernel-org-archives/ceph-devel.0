From: Xing Lin <xinglin@cs.utah.edu>
Subject: Re: which Linux kernel version corresponds to 0.48argonaut?
Date: Sat, 05 Jan 2013 18:55:43 -0700
Message-ID: <50E8D99F.3090008@cs.utah.edu>
References: <50D35ECA.4040602@cs.utah.edu> <50D3BD69.8010305@cs.utah.edu> <CAPYLRzhi2h_YDP7zdobMQepGA8ntQOqQgY+rP4AKvjvH3=-+WA@mail.gmail.com> <alpine.DEB.2.00.1301041633340.6109@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from rio.cs.utah.edu ([155.98.64.241]:34032 "EHLO
	mail-svr1.cs.utah.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754931Ab3AFBzp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 5 Jan 2013 20:55:45 -0500
In-Reply-To: <alpine.DEB.2.00.1301041633340.6109@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Gregory Farnum <greg@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Sage,

[apologize if you receive this email twice: the mailing list rejected 
this email because it contains HTMLs]

Thanks very much for your confirmation. I appreciate it.

After changing the client-side code, I can map/unmap rbd block devices 
at client machines. However, I am not able to list rbd block devices. At 
the client machine, I first installed 0.48.2argonaut package for Ubuntu 
then I compiled and installed my own version according to instructions 
on this page ( http://ceph.com/docs/master/install/building-ceph/). The 
client failed to recognize the fifth bucket algorithm I added. I 
searched "unsupported bucket algorithm" in the ceph code base and that 
text only appeared in the src/crush/CrushWrapper.cc. I checked 
decode_crush_bucket() and it should be able to recognize the fifth 
algorithm. Even after I changed the error message (added print of 
"[XXX]" and values for two bucket algorithm macros), it still prints the 
same error message. So, it seems that my new version of CrushWrapper.cc 
is not used during compilation to create the final rbd binary. Would you 
please tell me where the problem is and how I can fix it? Thank you very 
much.


The related code section:
-------------------------------------------------------------------------------
// src/crush/crush.h
enum {
         CRUSH_BUCKET_UNIFORM = 1,
         CRUSH_BUCKET_LIST = 2,
         CRUSH_BUCKET_TREE = 3,
         CRUSH_BUCKET_STRAW = 4,
         CRUSH_BUCKET_DIRECTMAP = 5    /* return the rth item, use 
similar structure as UNIFORM */
};

// src/crush/CrushWrapper.cc
void CrushWrapper::decode_crush_bucket(crush_bucket** bptr, 
bufferlist::iterator &blp)
{
   __u32 alg;
   ::decode(alg, blp);
   if (!alg) {
     *bptr = NULL;
     return;
   }

   int size = 0;
   switch (alg) {
   case CRUSH_BUCKET_UNIFORM:
     size = sizeof(crush_bucket_uniform);
     break;
   // NOTE: this is my new bucket algorithm
   case CRUSH_BUCKET_DIRECTMAP:
     size = sizeof(crush_bucket_uniform);
     break;
   case CRUSH_BUCKET_LIST:
     size = sizeof(crush_bucket_list);
     break;
   case CRUSH_BUCKET_TREE:
     size = sizeof(crush_bucket_tree);
     break;
   case CRUSH_BUCKET_STRAW:
     size = sizeof(crush_bucket_straw);
     break;
   default:
     {
       char str[128];
       // NOTE: added "[XXX]"
       snprintf(str, sizeof(str), "[XXX]: unsupported bucket algorithm: 
%d, %d, %d",
         alg, CRUSH_BUCKET_DIRECTMAP, CRUSH_BUCKET_UNIFORM);
       throw buffer::malformed_input(str);
     }
   }

--------------------------------------------------------------------------------
root@client:/mnt/ceph-0.48.2argonaut.fast# rbd list
terminate called after throwing an instance of 
'ceph::buffer::malformed_input'
   what():  buffer::malformed_input: unsupported bucket algorithm: 5
*** Caught signal (Aborted) **
  in thread 7f14733ca700
  ceph version 0.48.2argonaut.fast 
(commit:000000000000000000000000000000000000000000000)
  1: rbd() [0x42991a]
  2: (()+0xfcb0) [0x7f147715acb0]
  3: (gsignal()+0x35) [0x7f14758b8445]
  4: (abort()+0x17b) [0x7f14758bbbab]
  5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7f147620669d]
  6: (()+0xb5846) [0x7f1476204846]
  7: (()+0xb5873) [0x7f1476204873]
  8: (__cxa_rethrow()+0x46) [0x7f14762049b6]
  9: (CrushWrapper::decode(ceph::buffer::list::iterator&)+0xd28) 
[0x7f14775ea878]
  10: (OSDMap::decode(ceph::buffer::list::iterator&)+0x691) [0x7f147758cab1]
  11: (OSDMap::decode(ceph::buffer::list&)+0x3e) [0x7f147758d55e]
  12: (Objecter::handle_osd_map(MOSDMap*)+0x1b12) [0x7f147747b1d2]
  13: (librados::RadosClient::_dispatch(Message*)+0x54) [0x7f1477455664]
  14: (librados::RadosClient::ms_dispatch(Message*)+0xbb) [0x7f147745579b]
  15: (SimpleMessenger::DispatchQueue::entry()+0x903) [0x7f1477571be3]
  16: (SimpleMessenger::dispatch_entry()+0x24) [0x7f1477572984]
  17: (SimpleMessenger::DispatchThread::entry()+0xd) [0x7f1477457c1d]
  18: (()+0x7e9a) [0x7f1477152e9a]
  19: (clone()+0x6d) [0x7f14759744bd]
2013-01-05 18:29:40.640923 7f14733ca700 -1 *** Caught signal (Aborted) **
  in thread 7f14733ca700

Xing

On 01/04/2013 05:34 PM, Sage Weil wrote:
> On Fri, 4 Jan 2013, Gregory Farnum wrote:
>> I think they might be different just as a consequence of being updated
>> less recently; that's where all of the lines whose origin I recognize
>> differ (not certain about the calc_parents stuff though). Sage can
>> confirm.
> In general, the crush files in mainline should track the same files in
> ceph.git master, modulo the #include lines at the top.  0.48argonaut is
> sufficiently old that the linux versions are actually newer.
>
>> The specific issue you encountered previously was of course because
>> you changed the layout algorithm and the client needs to be able to
>> process that layout itself.
> Yep!
> sage
>
>
>> -Greg
>>
>> On Thu, Dec 20, 2012 at 5:37 PM, Xing Lin <xinglin@cs.utah.edu> wrote:
>>> This may be useful for other Ceph newbies just like me.
>>>
>>> I have ported my changes to 0.48argonaut to related Ceph files included in
>>> Linux, though files with the same name are not exactly the same. Then I
>>> recompiled and installed the kernel. After that, everything seems to be
>>> working again now: Ceph is working with my new simple replica placement
>>> algorithm. :)
>>> So, it seems that Ceph files included in the Linux kernel are supposed to be
>>> different from those in 0.48argonaut. Presumably, the Linux kernel contains
>>> the client-side implementation while 0.48argonaut contains the server-side
>>> implementation. It would be appreciated if someone can confirm it. Thank
>>> you!
>>>
>>> Xing
>>>
>>>
>>> On 12/20/2012 11:54 AM, Xing Lin wrote:
>>>> Hi,
>>>>
>>>> I was trying to add a simple replica placement algorithm in Ceph. This
>>>> algorithm simply returns r_th item in a bucket for the r_th replica. I have
>>>> made that change in Ceph source code (including files such as crush.h,
>>>> crush.c, mapper.c, ...) and I can run Ceph monitor and osd daemons. However,
>>>> I am not able to map rbd block devices at client machines. 'rbd map image0'
>>>> reported "input/output error" and 'dmesg' at the client machine showed
>>>> message like "libceph: handle_map corrupt msg". I believe that is because I
>>>> have not ported my changes to Ceph client side programs and it does not
>>>> recognize the new placement algorithm. I probably need to recompile the rbd
>>>> block device driver. When I was trying to replace Ceph related files in
>>>> Linux with my own version, I noticed that files in Linux-3.2.16 are
>>>> different from these included in Ceph source code. For example, the
>>>> following is the diff of crush.h in Linux-3.2.16 and 0.48argonaut. So, my
>>>> question is that is there any version of Linux that contains the exact Ceph
>>>> files as included in 0.48argonaut? Thanks.
>>>>
>>>> -------------------
>>>>   $ diff -uNrp ceph-0.48argonaut/src/crush/crush.h
>>>> linux-3.2.16/include/linux/crush/crush.h
>>>> --- ceph-0.48argonaut/src/crush/crush.h    2012-06-26 11:56:36.000000000
>>>> -0600
>>>> +++ linux-3.2.16/include/linux/crush/crush.h    2012-04-22
>>>> 16:31:32.000000000 -0600
>>>> @@ -1,12 +1,7 @@
>>>>   #ifndef CEPH_CRUSH_CRUSH_H
>>>>   #define CEPH_CRUSH_CRUSH_H
>>>>
>>>> -#if defined(__linux__)
>>>>   #include <linux/types.h>
>>>> -#elif defined(__FreeBSD__)
>>>> -#include <sys/types.h>
>>>> -#include "include/inttypes.h"
>>>> -#endif
>>>>
>>>>   /*
>>>>    * CRUSH is a pseudo-random data distribution algorithm that
>>>> @@ -156,24 +151,25 @@ struct crush_map {
>>>>       struct crush_bucket **buckets;
>>>>       struct crush_rule **rules;
>>>>
>>>> +    /*
>>>> +     * Parent pointers to identify the parent bucket a device or
>>>> +     * bucket in the hierarchy.  If an item appears more than
>>>> +     * once, this is the _last_ time it appeared (where buckets
>>>> +     * are processed in bucket id order, from -1 on down to
>>>> +     * -max_buckets.
>>>> +     */
>>>> +    __u32 *bucket_parents;
>>>> +    __u32 *device_parents;
>>>> +
>>>>       __s32 max_buckets;
>>>>       __u32 max_rules;
>>>>       __s32 max_devices;
>>>> -
>>>> -    /* choose local retries before re-descent */
>>>> -    __u32 choose_local_tries;
>>>> -    /* choose local attempts using a fallback permutation before
>>>> -     * re-descent */
>>>> -    __u32 choose_local_fallback_tries;
>>>> -    /* choose attempts before giving up */
>>>> -    __u32 choose_total_tries;
>>>> -
>>>> -    __u32 *choose_tries;
>>>>   };
>>>>
>>>>
>>>>   /* crush.c */
>>>> -extern int crush_get_bucket_item_weight(const struct crush_bucket *b, int
>>>> pos);
>>>> +extern int crush_get_bucket_item_weight(struct crush_bucket *b, int pos);
>>>> +extern void crush_calc_parents(struct crush_map *map);
>>>>   extern void crush_destroy_bucket_uniform(struct crush_bucket_uniform *b);
>>>>   extern void crush_destroy_bucket_list(struct crush_bucket_list *b);
>>>>   extern void crush_destroy_bucket_tree(struct crush_bucket_tree *b);
>>>> @@ -181,9 +177,4 @@ extern void crush_destroy_bucket_straw(s
>>>>   extern void crush_destroy_bucket(struct crush_bucket *b);
>>>>   extern void crush_destroy(struct crush_map *map);
>>>>
>>>> -static inline int crush_calc_tree_node(int i)
>>>> -{
>>>> -    return ((i+1) << 1)-1;
>>>> -}
>>>> -
>>>>   #endif
>>>>
>>>> ----
>>>> Xing
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>


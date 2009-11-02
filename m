From: Noah Watkins <jayhawk@soe.ucsc.edu>
Subject: Re: patch: update object mapping calculation
Date: Mon, 2 Nov 2009 15:34:30 -0800
Message-ID: <9A7BD19A-A868-4450-BAA2-A7E925F8FA95@soe.ucsc.edu>
References: <04BF1C09-FD96-4666-8C0B-31416E1ECC3C@soe.ucsc.edu>
	<Pine.LNX.4.64.0910281458380.18824@cobra.newdream.net>
	<6C4FFEC7-CAB3-4B30-B96F-A54E539267AA@soe.ucsc.edu>
	<Pine.LNX.4.64.0911021333270.9680@cobra.newdream.net>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.64.0911021333270.9680@cobra.newdream.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@lists.sourceforge.net
List-Id: ceph-devel.vger.kernel.org

Sage

How do you prefer patches being sent? It looks like you are cherry- 
picking out of my tree to apply your signed-off-by? Rebasing my for- 
sage tree means that I can't fast-forward the public branch, but  
forcing the fast-forward is probably easiest if you aren't ever  
pulling from it.

Thoughts?

-n

On Nov 2, 2009, at 1:34 PM, Sage Weil wrote:

> On Fri, 30 Oct 2009, Noah Watkins wrote:
>
>>
>>> Actually, it looks like that calculation is wrong.. I also added
>>>
>>> 	*oxoff += (stripeno % su_per_object) * su;
>>
>> Looks like this update fixes the object offset for multiple stripes
>> per object, but 'oxlen' needs adjusted. With the current calculation:
>>
>> - oxlen = min(plen, offset % su)
>>
>> A length of zero is calculated when offset equals stripe unit.
>> Consider osize=128, stripe unit = 64, stripe count = 2. A write
>> request of
>>
>> length, offset
>> 4096, 0
>>
>> gives:
>> ono = 0, oxoff = 0, oxlen = 64
>> ono = 1, oxoff = 0, oxlen = 64
>> ono = 0, oxoff = 64, oxlen = 0 <-- infinite loop wrt to calling  
>> context
>>
>> So, assuming that object size is a multiple of stripe unit, we really
>> want the minimum between the total request and the remaining space in
>> the current stripe:
>>
>> - oxlen = min(plen, su - (offset % su))
>>
>> I put a path in against ceph-client/unstable @
>>
>> http://code.noahdesu.com/git/linux26-dev.git ceph/unstable-for-sage
>
> Applied, thanks!
>
> sage
>
>
>>
>> -n
>>
>> -------------
>>
>> diff --git a/fs/ceph/osdmap.c b/fs/ceph/osdmap.c
>> index 5a5520c..d62e111 100644
>> --- a/fs/ceph/osdmap.c
>> +++ b/fs/ceph/osdmap.c
>> @@ -731,7 +731,7 @@ void ceph_calc_file_object_mapping(struct
>> ceph_file_layout *layout,
>>          u32 sc = le32_to_cpu(layout->fl_stripe_count);
>>          u32 bl, stripeno, stripepos, objsetno;
>>          u32 su_per_object;
>> -       u64 t;
>> +       u64 t, su_offset;
>>
>>          dout("mapping %llu~%llu  osize %u fl_su %u\n", off, *plen,
>>               osize, su);
>> @@ -755,10 +755,15 @@ void ceph_calc_file_object_mapping(struct
>> ceph_file_layout *layout,
>>
>>          /* *oxoff = *off % layout->fl_stripe_unit;  # offset in  
>> su */
>>          t = off;
>> -       *oxoff = do_div(t, su);
>> -       *oxoff += (stripeno % su_per_object) * su;
>> -
>> -       *oxlen = min_t(u64, *plen, su - *oxoff);
>> +       su_offset = do_div(t, su);
>> +       *oxoff = su_offset + (stripeno % su_per_object) * su;
>> +
>> +       /*
>> +        * Calculate the length of the extent being written to the
>> selected
>> +        * object. This is the minimum of the full length requested
>> (plen) or
>> +        * the remainder of the current stripe being written to.
>> +        */
>> +       *oxlen = min_t(u64, *plen, su - su_offset);
>>          *plen = *oxlen;
>>
>>          dout(" obj extent %llu~%llu\n", *oxoff, *oxlen);
>>
>>
>> --------------------------------------------------------------------- 
>> ---------
>> Come build with us! The BlackBerry(R) Developer Conference in SF, CA
>> is the only developer event you need to attend this year.  
>> Jumpstart your
>> developing skills, take BlackBerry mobile applications to market  
>> and stay
>> ahead of the curve. Join us from November 9 - 12, 2009. Register now!
>> http://p.sf.net/sfu/devconference
>> _______________________________________________
>> Ceph-devel mailing list
>> Ceph-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/ceph-devel
>>
>>


------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference

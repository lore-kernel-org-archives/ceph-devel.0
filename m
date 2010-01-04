From: Dallas Kashuba <dallas@newdream.net>
Subject: Re: ceph in v2.6.33?
Date: Mon, 4 Jan 2010 12:15:57 -0800
Message-ID: <66CFAE0F-0517-42AE-9F84-346DF5503AAC@newdream.net>
References: <4B40DFF7.7030004@scalableinformatics.com>
	<87iqbic7lj.fsf@basil.nowhere.org>
	<4B4202EF.4000206@scalableinformatics.com>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <4B4202EF.4000206@scalableinformatics.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: landman@scalableinformatics.com
Cc: ceph-devel@lists.sourceforge.net
List-Id: ceph-devel.vger.kernel.org


On Jan 4, 2010, at 7:02 AM, Joe Landman wrote:

> Andi Kleen wrote:
>> Joe Landman <landman@scalableinformatics.com> writes:
>> 
>>> Sage:
>>> 
>>>   We (my company) have been following Ceph for a while.  We are looking 
>>> forward to being able to offer this as part of our siCluster storage 
>>> cluster offering.
>>> 
>>>   Let me know if a note to Linus/LKML would help.  We would like to see 
>>> the code in the kernel (we roll our own kernels for support/performance 
>>> reasons).
>> 
>> The interesting question is if you actually use it. Do you?
> 
> Hi Andi
> 
>   We've had a few systems with it set up in the recent past (within the 
> last 2 months), but they are our lab/demo/engineering systems for 
> testing things, and they are out at customer sites right now running 
> other tools.
> 
>   We have had, and continue to have testing going on with Ceph, BTRFS, 
> NILFS2.  We actively use and support glusterfs, and have customers using 
> Lustre, PVFS2, and others.  We have been looking at pohmelfs and others 
> as potentially interesting.
> 
>   So, yes, we have used it for testing purposes, hence our interest in 
> seeing it included.
> 
> Joe


How has your testing been going with it?  Have you been bumping into many problems?

 - Dallas


>> 
>> Linus asked for a user-base.
>> 
>> -Andi
> 
> 
> -- 
> Joseph Landman, Ph.D
> Founder and CEO
> Scalable Informatics Inc.
> email: landman@scalableinformatics.com
> web  : http://scalableinformatics.com
>        http://scalableinformatics.com/jackrabbit
> phone: +1 734 786 8423 x121
> fax  : +1 866 888 3112
> cell : +1 734 612 4615
> 


------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 

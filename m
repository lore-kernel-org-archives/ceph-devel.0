From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: Ceph fixes for 3.10.y
Date: Tue, 7 Jan 2014 13:25:26 +0200
Message-ID: <CALFYKtDve0Ka31bq0dBWBinzK_dmLrLOboeL=Vj3tax2LEB4nQ@mail.gmail.com>
References: <alpine.DEB.2.00.1312310819370.19234@cobra.newdream.net>
	<20140106220917.GC4919@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20140106220917.GC4919@kroah.com>
Sender: stable-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Sage Weil <sage@inktank.com>, stable@vger.kernel.org, Ceph Development <ceph-devel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Tue, Jan 7, 2014 at 12:09 AM, Greg KH <greg@kroah.com> wrote:
> On Tue, Dec 31, 2013 at 08:21:19AM -0800, Sage Weil wrote:
>> Hi Greg,
>>
>> This is a somewhat long overdue set of fixes for 3.10.y.  Since there
>> are a lot of patches, they can be pulled from
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git for-stable-3.10.24
>>
>> If you prefer, I can send them as separate emails instead.  Note that this
>> branch includes the 2 patches from the 3.12.y series you already picked
>> up.
>>
>> They are all reviewed, retested, and reference the original upstream
>> commit (via git cherry-pick -x).
>
> I've applied all of these now, but please be careful when doing these
> backports, your "cherrypicked from" lines didn't all match up with real
> git ids in Linus's tree (hint look at the patches that had multiple
> cherry-pick lines...)

Hi Greg,

Sorry, it's my screw up.  I've rechecked, the following three commits
are affected:

  ceph: cleanup types in striped_read()
  ceph: fix bugs about handling short-read for sync read mode.
  ceph: allow sync_read/write return partial successed size of read/write.

The first "cherry picked from" line for all of those three commits is
correct, while the second of course is bogus.  It looks like
I accidentally cherry picked those commits twice: first to the testing
branch and then to the real for-stable.  Will be more careful in the
future!

Thanks,

                Ilya

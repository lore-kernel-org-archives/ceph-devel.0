From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: consequences of XFS_IOC_FSSETXATTR on non-empty file?
Date: Sun, 13 Jul 2014 21:01:13 +0400
Message-ID: <CALFYKtC7J1ZvW40wsSWmVpNS5T3tmAOmY9CP=nsh4r=iUjeznA@mail.gmail.com>
References: <CA+4uBUYg+81G2=sj3qXO4GGgA7pyjgVrGDCN+UQ32jnWgSbG5w@mail.gmail.com>
	<20140713012624.GS4453@dastard>
	<CA+4uBUZwuh5t28jU5jfQb3ApdUKx8t88hg6m8CXS+0ztpi6OTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <xfs-bounces@oss.sgi.com>
In-Reply-To: <CA+4uBUZwuh5t28jU5jfQb3ApdUKx8t88hg6m8CXS+0ztpi6OTw@mail.gmail.com>
List-Unsubscribe: <http://oss.sgi.com/mailman/options/xfs>,
	<mailto:xfs-request@oss.sgi.com?subject=unsubscribe>
List-Archive: <http://oss.sgi.com/pipermail/xfs>
List-Post: <mailto:xfs@oss.sgi.com>
List-Help: <mailto:xfs-request@oss.sgi.com?subject=help>
List-Subscribe: <http://oss.sgi.com/mailman/listinfo/xfs>,
	<mailto:xfs-request@oss.sgi.com?subject=subscribe>
Errors-To: xfs-bounces@oss.sgi.com
Sender: xfs-bounces@oss.sgi.com
To: Samuel Just <sam.just@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>, xfs@oss.sgi.com
List-Id: ceph-devel.vger.kernel.org

On Sun, Jul 13, 2014 at 5:48 AM, Samuel Just <sam.just@inktank.com> wrote:
> Actually, on this ubuntu kernel (3.13.0-24-generic), it doesn't seem
> to give an error.  I'll attach my test case for that.  We don't yet
> have a way of reproducing the corruption -- the ext_size change in the
> osd simply seemed like a promising lead.
> -Sam
>
> On Sat, Jul 12, 2014 at 6:26 PM, Dave Chinner <david@fromorbit.com> wrote:
>> On Sat, Jul 12, 2014 at 06:16:54PM -0700, Samuel Just wrote:
>>> Hi,
>>>
>>> We are seeing reports of ceph-osd stores on xfs of files with some
>>> garbage data (possibly misplaced from data elsewhere in the
>>> filesystem).  There was a bug for a while where the ceph-osd process
>>> would set a value for fsx_extsize on a non-empty (possibly sparse)
>>> file using XFS_IOC_FSSETXATTR.  Could that plausibly result in a file
>>> with garbage data?
>>
>> No, setting an extent size on a non-empty file will simply fail
>> with EINVAL.

AFAIR it checks whether or not any extents are actually allocated, not
whether the file is empty or not.  I think if you call fsync() or even
fdatasync() before close(fd), it will fail as expected.

Thanks,

                Ilya

_______________________________________________
xfs mailing list
xfs@oss.sgi.com
http://oss.sgi.com/mailman/listinfo/xfs

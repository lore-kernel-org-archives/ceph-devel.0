From: Samuel Just <sam.just-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: RADOS translator for GlusterFS
Date: Mon, 5 May 2014 10:46:16 -0700
Message-ID: <CA+4uBUavv2d63qn0zY=yfS7KV4c45JH6Dr0PupKa+zTOh2GC1Q@mail.gmail.com>
References: <980181538.654650.1399300829103.JavaMail.zimbra@redhat.com>
	<355696287.706122.1399303290204.JavaMail.zimbra@redhat.com>
	<CABBk=J8=GgAPM7qWfs9=OZt6yHVERggiugPui31w4b=GPk8Oow@mail.gmail.com>
	<1793642728.775752.1399309685692.JavaMail.zimbra@redhat.com>
	<CA+4uBUaOWEwpet3dr1mzYQtr_Xju8a3aCgFAf4BCu22WGQ+aZg@mail.gmail.com>
	<1666953774.790843.1399311496408.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <gluster-devel-bounces-+FkPdpiNhgJAfugRpC6u6w@public.gmane.org>
In-Reply-To: <1666953774.790843.1399311496408.JavaMail.zimbra-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <http://supercolony.gluster.org/mailman/options/gluster-devel>,
	<mailto:gluster-devel-request-+FkPdpiNhgJAfugRpC6u6w@public.gmane.org?subject=unsubscribe>
List-Archive: <http://supercolony.gluster.org/pipermail/gluster-devel/>
List-Post: <mailto:gluster-devel-+FkPdpiNhgJAfugRpC6u6w@public.gmane.org>
List-Help: <mailto:gluster-devel-request-+FkPdpiNhgJAfugRpC6u6w@public.gmane.org?subject=help>
List-Subscribe: <http://supercolony.gluster.org/mailman/listinfo/gluster-devel>,
	<mailto:gluster-devel-request-+FkPdpiNhgJAfugRpC6u6w@public.gmane.org?subject=subscribe>
Sender: gluster-devel-bounces-+FkPdpiNhgJAfugRpC6u6w@public.gmane.org
Errors-To: gluster-devel-bounces-+FkPdpiNhgJAfugRpC6u6w@public.gmane.org
To: Jeff Darcy <jdarcy-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, gluster-devel-+FkPdpiNhgJAfugRpC6u6w@public.gmane.org, Yehuda Sadeh <yehuda-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

It's very important, several kinds of blocking are done at object
granularity.  Off the top of my head, large objects would cause deep
scrub and recovery to stall requests for longer.  Elephant objects
would also be able to skew data distribution.
-Sam

On Mon, May 5, 2014 at 10:38 AM, Jeff Darcy <jdarcy-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>> One important caveat is that rados objects should be limited in size
>> (4MB for rbd blocks), so you'll want to chunk files somewhere before
>> rados.
>
> OK, that's going to make life interesting.  How dire are the results
> of not chunking like this?  Is it just that the data won't be
> distributed across multiple OSDs and therefore you'll only get one
> OSD's worth of throughput?  Or is it something worse?  There might
> be a way that we can use the GlusterFS striping translator on top
> of the RADOS translator, but since it currently sits one level lower
> (still above replication but below distribution) there might be some
> issues there.

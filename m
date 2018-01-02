From: Dan Mick <dmick-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: formatting bytes and object counts in ceph status
 ouput
Date: Tue, 2 Jan 2018 15:44:34 -0800
Message-ID: <6eed9c92-fe9d-bfb0-0978-f3ba43f875f1@redhat.com>
References: <20180102104303.hr4ohy2dkxapj6id@jf_suse_laptop>
 <CALe9h7fCJHV+UPeNUreN-gbK3xgdBgmDJLqxC+6ZiDTA1YPPSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CALe9h7fCJHV+UPeNUreN-gbK3xgdBgmDJLqxC+6ZiDTA1YPPSQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: John Spray <jspray-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ceph-Users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On 01/02/2018 08:54 AM, John Spray wrote:
> On Tue, Jan 2, 2018 at 10:43 AM, Jan Fajerski <jfajerski-IBi9RG/b67k@public.gmane.org> wrote:
>> Hi lists,
>> Currently the ceph status output formats all numbers with binary unit
>> prefixes, i.e. 1MB equals 1048576 bytes and an object count of 1M equals
>> 1048576 objects.  I received a bug report from a user that printing object
>> counts with a base 2 multiplier is confusing (I agree) so I opened a bug and
>> https://github.com/ceph/ceph/pull/19117.
>> In the PR discussion a couple of questions arose that I'd like to get some
>> opinions on:
> 
>> - Should we print binary unit prefixes (MiB, GiB, ...) since that would be
>> technically correct?
> 
> I'm not a fan of the technically correct base 2 units -- they're still
> relatively rarely used, and I've spent most of my life using kB to
> mean 1024, not 1000.
> 
>> - Should counters (like object counts) be formatted with a base 10
>> multiplier or  a multiplier woth base 2?
> 
> I prefer base 2 for any dimensionless quantities (or rates thereof) in
> computing.  Metres and kilograms go in base 10, bytes go in base 2.
> 
> It's all very subjective and a matter of opinion of course, and my
> feelings aren't particularly strong :-)
> 
> John

100% agreed.  "iB" is an affectation IMO.  But I'm grumpy and old.

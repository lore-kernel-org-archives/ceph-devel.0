From: Wido den Hollander <wido-fspyXLx8qC4@public.gmane.org>
Subject: Re: radosgw-admin reshard stale-instances rm experience
Date: Tue, 26 Feb 2019 11:45:17 +0100
Message-ID: <2ac27e48-ae95-bd5d-c97d-88b21944c209@42on.com>
References: <5f56b87b-b1ee-0844-5230-93618032ccbb@42on.com>
 <CAD9yTbF_S97rOTGPTbKO8Gs7ZP99Ymi056_NisWbuJKFeBZjTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAD9yTbF_S97rOTGPTbKO8Gs7ZP99Ymi056_NisWbuJKFeBZjTQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Paul Emmerich <paul.emmerich-iZXOWb+A65A@public.gmane.org>
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org



On 2/21/19 9:19 PM, Paul Emmerich wrote:
> On Thu, Feb 21, 2019 at 4:05 PM Wido den Hollander <wido-fspyXLx8qC4@public.gmane.org> wrote:
>> This isn't available in 13.2.4, but should be in 13.2.5, so on Mimic you
>> will need to wait. But this might bite you at some point.
> 
> Unfortunately it hasn't been backported to Mimic:
> http://tracker.ceph.com/issues/37447
> 

I see. We really need this in Mimic as well. I have another cluster,
which is running Mimic, but it's a suspect as well.

547 buckets, but 290k objects in the index pool. That ratio is not correct.

> This is the Luminous backport:
> https://github.com/ceph/ceph/pull/25326/files which looks a little bit
> messy because it fixes 3 related issues in one backport.
> 
> CC'ing devel: best way to get this in Mimic?
> 

I'd love to know as well.

Wido

> Paul
> 

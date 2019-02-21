From: Paul Emmerich <paul.emmerich-iZXOWb+A65A@public.gmane.org>
Subject: Re: radosgw-admin reshard stale-instances rm experience
Date: Thu, 21 Feb 2019 21:19:23 +0100
Message-ID: <CAD9yTbF_S97rOTGPTbKO8Gs7ZP99Ymi056_NisWbuJKFeBZjTQ@mail.gmail.com>
References: <5f56b87b-b1ee-0844-5230-93618032ccbb@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <5f56b87b-b1ee-0844-5230-93618032ccbb-fspyXLx8qC4@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Wido den Hollander <wido-fspyXLx8qC4@public.gmane.org>
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Thu, Feb 21, 2019 at 4:05 PM Wido den Hollander <wido-fspyXLx8qC4@public.gmane.org> wrote:
> This isn't available in 13.2.4, but should be in 13.2.5, so on Mimic you
> will need to wait. But this might bite you at some point.

Unfortunately it hasn't been backported to Mimic:
http://tracker.ceph.com/issues/37447

This is the Luminous backport:
https://github.com/ceph/ceph/pull/25326/files which looks a little bit
messy because it fixes 3 related issues in one backport.

CC'ing devel: best way to get this in Mimic?

Paul

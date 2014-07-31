From: Gregory Farnum <greg-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: question about ApplyManager,
	SubmitManager and FileJournal
Date: Thu, 31 Jul 2014 15:00:38 -0400
Message-ID: <CAPYLRzgz6j5z0ir+tQz48Uqi4=0J0XRR6Esh+swPiWZL=Sjgqg@mail.gmail.com>
References: <b122136.df6f.1478d3cd445.Coremail.fastsync@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <b122136.df6f.1478d3cd445.Coremail.fastsync-9Onoh4P/yGk@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: yuelongguang <fastsync-9Onoh4P/yGk@public.gmane.org>
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

These sorts of questions are good for ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
which I've added. :)

On Thu, Jul 31, 2014 at 12:24 PM, yuelongguang <fastsync-9Onoh4P/yGk@public.gmane.org> wrote:
> hi,all
> recently i dive into the source code, i am a little confused about them,
> maybe because of many threads,wait,seq.
>
> 1. what does apply_manager  do? it is related to filestore and file journal.

It's a utility class implemented in the "JournalingObjectStore" class
(which FileStore inherits from and implements). I'm not super familiar
with this system but it's basically just the functions that deal with
committing writes to the journal and applying them to the backing
filesystem.

> 2. what does SubmitManager  do?

This one is used by the FileStore when it's actively submitting ops;
the real purpose is pretty much to take and drop a lock which
serializes the operations and protects access to various data members.

> 3. how they interact and work together?

Perhaps you can ask a more specific question?
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com

From: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Subject: Re: Ceph release cadence
Date: Fri, 22 Sep 2017 22:28:01 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1709222211280.16664@piezo.novalocal>
References: <alpine.DEB.2.11.1709061523170.16664@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1709061523170.16664-qHenpvqtifaMSRpgCs4c+g@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

Here is a concrete proposal for everyone to summarily shoot down (or 
heartily endorse, depending on how your friday is going):

- 9 month cycle
- enforce a predictable release schedule with a freeze date and 
  a release date.  (The actual .0 release of course depends on no blocker 
  bugs being open; not sure how zealous 'train' style projects do 
  this.)
- no more even/odd pattern; all stable releases are created equal.
- support upgrades from up to 3 releases back.

This shortens the cycle a bit to relieve the "this feature must go in" 
stress, without making it so short as to make the release pointless (e.g., 
infernalis, kraken).  (I also think that the feature pressure is much 
lower now than it has been in the past.)

This creates more work for the developers because there are more upgrade 
paths to consider: we no longer have strict "choke points" (like all 
upgrades must go through luminous).  We could reserve the option to pick 
specific choke point releases in the future, perhaps taking care to make 
sure these are the releases that go into downstream distros.  We'll need 
to be more systematic about the upgrade testing.

Somewhat separately, several people expressed concern about having stable 
releases to develop against.  This is somewhat orthogonal to what users 
need.  To that end, we can do a dev checkpoint every 1 or 2 months 
(preferences?), where we fork a 'next' branch and stabilize all of the 
tests before moving on.  This is good practice anyway to avoid 
accumulating low-frequency failures in the test suite that have to be 
squashed at the end.

The timing of the 9 mo cycle could be chosen to strategically avoid 
holiday periods.  E.g, Feb 1, May 1, Aug 1, Nov 1 (hard to miss both Dec 
and Aug, unfortunately).

Thoughts?  Counter-proposals?

sage

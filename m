From: Lars Marowsky-Bree <lmb@suse.com>
Subject: Re: Monitoring ceph and prometheus
Date: Fri, 19 May 2017 13:00:45 +0200
Message-ID: <20170519110045.nsam4hsu7wokqi7m@suse.com>
References: <20170511115211.isjqn6y3x2tuqxbo@jf_suse_laptop>
 <CALe9h7ed4aUDYEJKfH8qSoVmiPB8+F+g7+ffzrwE08sdX7RHSQ@mail.gmail.com>
 <alpine.DEB.2.11.1705111246400.18953@piezo.novalocal>
 <20170513101414.wisczvozh6kilps7@suse.com>
 <CALe9h7fhson-vgFpbUoi+x+nSiqZRw72qmKKEMgrT-KQtWy93g@mail.gmail.com>
 <20170515064449.hsbl7l6zzkuwowq2@suse.com>
 <CALe9h7c9vdgKc3rSG853Lmbr=oan73Y32jxc+-1gWfniRV_iaw@mail.gmail.com>
 <20170518083716.s4kv4d5gus7e2trb@suse.com>
 <CALe9h7fBzp4wi3OSzjMpbigz+zwzti=GZfBWwO1m1SzL65gang@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:60746 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750943AbdESLAx (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Fri, 19 May 2017 07:00:53 -0400
Content-Disposition: inline
In-Reply-To: <CALe9h7fBzp4wi3OSzjMpbigz+zwzti=GZfBWwO1m1SzL65gang@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

On 2017-05-18T10:03:25, John Spray <jspray@redhat.com> wrote:

> > Fair enough. The point that they may wish to gather information at
> > different frequencies still remains though - a ceph-mgr module may do it
> > on-demand for certain tasks, event driven, or periodically, prometheus
> > (or other trending) would want to poll certain counters at various
> > frequencies, etc.
> I'm slightly getting the impression that you might not have noticed
> the existing functionality here -- the perf counters are sent
> continuously from the daemons to the mgr, rather than being polled.
> The mgr is in control of how often that is (via the MMgrConfigure
> message).

Oh, sorry. Should have been more clear. I'm aware of this, I just don't
like it - and the fact that the mgr needs to adjust the push interval
just highlights why too, because if something like Prometheus then
wanted to pull from the mgr, those intervals would need to be aligned.


-- 
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
"Experience is the name everyone gives to their mistakes." -- Oscar Wilde


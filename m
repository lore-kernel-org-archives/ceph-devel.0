From: Nathan Cutler <ncutler-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: HELP! --> CLUSER DOWN (was "v13.2.1 Mimic
 released")
Date: Mon, 30 Jul 2018 10:54:18 +0200
Message-ID: <c0ca6365-93d3-ddcb-1260-52bae8209893@suse.cz>
References: <alpine.DEB.2.11.1807271924250.15688@piezo.novalocal>
 <086B2EB1-4349-4694-856C-ECA50FBF6211@godaddy.com>
 <trinity-977054d3-80b8-4be9-9a69-009e8b25c718-1532789176388@3c-app-gmx-bs12>
 <422702b2-35c6-413e-bb9f-506921ccb3fc@email.android.com>
 <trinity-331a4fa8-ed1e-4a06-8e8f-0b2519cf5904-1532813725473@3c-app-gmx-bs14>
 <trinity-ac10e367-ef5e-458d-b5aa-d1d671b3a5c7-1532826164122@3c-app-gmx-bs02>
 <CAKPXa=ZLDi17fnf5gq0RfGPp_RGoFWQ7EutbqPuJ7OoJte=G_w@mail.gmail.com>
 <trinity-5e17c1fa-bf9a-4faf-b6d8-4ddde0463064-1532855791187@3c-app-gmx-bs56>
 <7404124f-008d-744e-9866-9a41ca88bd79@suse.cz>
 <trinity-6a6dc71a-9bf5-4999-817a-ba833afe2a8d-1532937024317@3c-app-gmx-bs73>
 <df40714b-4dd4-06cc-b104-d70b9f3d3536@physik.uni-bonn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <df40714b-4dd4-06cc-b104-d70b9f3d3536-PRwTpj6vllKyLsESG3L8NIQuADTiUCJX@public.gmane.org>
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
To: Oliver Freyermuth <freyermuth-PRwTpj6vllKyLsESG3L8NIQuADTiUCJX@public.gmane.org>, ceph.novice-k4R3PER4nllwCEqMux5wBA@public.gmane.org
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, Peter Wienemann <wienemann-PRwTpj6vllKyLsESG3L8NIQuADTiUCJX@public.gmane.org>, Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

> for all others on this list, it might also be helpful to know which setups are likely affected.
> Does this only occur for Filestore disks, i.e. if ceph-volume has taken over taking care of these?
> Does it happen on every RHEL 7.5 system?

It affects all OSDs managed by ceph-disk on all RHEL systems (but not on 
CentOS), regardless of whether they are filestore or bluestore.

> We're still on 13.2.0 here and ceph-detect-init works fine on our CentOS 7.5 systems (it just echoes "systemd").
> We're on Bluestore.
> Should we hold off on an upgrade, or are we unaffected?

The regression does not affect CentOS - only RHEL.

Nathan

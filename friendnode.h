#ifndef FRIENDNODE_H
#define FRIENDNODE_H
class GraphModel;
class FriendListModel;
class StrangerListModel;
class FriendNode
{
    friend GraphModel;
    friend FriendListModel;
    friend StrangerListModel;
public:
    static const long long invalid=-2;
    static const long long isFriend=-1;
    FriendNode();
    FriendNode(const long long);
    FriendNode(const long long ,const long long);
private:
    long long no;
    long long connectivity;
};

#endif // FRIENDNODE_H

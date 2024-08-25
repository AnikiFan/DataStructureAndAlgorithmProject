#ifndef FRIENDNODE_H
#define FRIENDNODE_H
class GraphModel;
class FriendNode
{
    friend GraphModel;
public:
    FriendNode();
    FriendNode(const long long);
    FriendNode(const long long ,const bool,const long long);
private:
    long long no;
    bool isFriend;
    long long connectivity;
};

#endif // FRIENDNODE_H
